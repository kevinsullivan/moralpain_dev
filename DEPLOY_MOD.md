# Deploying MoralPain

Step-by-step guide to deploying the moral-distress reporting system to AWS and running the Flutter app against it. Pairs with [GETTING_STARTED.md](GETTING_STARTED.md) for repo structure and prereqs.

> **⚠ This provisions real AWS resources** (S3, IAM, API Gateway, Lambda, Cognito) in **us-east-1**, and the bucket names are hardcoded with the `-26` suffix. Know which AWS account you're targeting and be ready to tear down with [infrastructure/delete](infrastructure/delete) when done.

---

## 0. Prerequisites

Run each. If any fails, fix it before continuing — the deploy will fail later otherwise.

```bash
aws sts get-caller-identity              # you're logged into the right AWS account
sceptre --version                        # Sceptre 3.x present
sam --version                            # AWS SAM CLI
flutter --version                        # Flutter 3.3.10 / Dart 2.18.6
jq --version                             # needed by smoke-test
```

If any of these is missing, see [GETTING_STARTED.md §2](GETTING_STARTED.md#2-development-environment) — the devcontainer has everything preinstalled.

### Environment assumptions

- **Region:** `us-east-1` (hardcoded in [infrastructure/config/config.yaml:2](infrastructure/config/config.yaml#L2)).
- **Bucket names:** All suffixed `-26` (see [infrastructure/deploy:33](infrastructure/deploy#L33) and [infrastructure/delete:35-46](infrastructure/delete#L35-L46)). These are account-global — if those names are already taken in another AWS account, deploy will fail.
- **AWS credentials:** Must have permission to create IAM, CloudFormation, S3, Cognito, API Gateway, and Lambda resources.

---

## 1. Deploy the infrastructure

One script deploys every CloudFormation stack (Sceptre resolves dependency order) and seeds the resources S3 bucket with the static JSON the `GET` endpoints proxy.

```bash
cd infrastructure
./deploy              # fresh deploy (sceptre create app)
./deploy --launch     # idempotent; use this to update an existing deploy
```

Expect ~5–10 min on a fresh account (the SAM API stack is the slowest — it packages Lambda code via SAM and creates the API Gateway + Cognito authorizer).

### What gets deployed

Sceptre walks [infrastructure/config/app/](infrastructure/config/app/) and brings up stacks in dependency order:

1. **S3 buckets** — `moralpain-submissions-26`, `moralpain-resources-26`, `moralpain-scratch-26`, plus `moralpain-site-26` (`DeletionPolicy: Retain`).
2. **IAM managed policies** (parallel with buckets).
3. **IAM roles** — the Lambda execution roles, attached to the managed policies above.
4. **SAM API** (stack `moralpain-api`) — API Gateway REST API, the four Lambdas (`GET`/`POST` for `/survey` and `/resiliency`), built by SAM from [infrastructure/code/](infrastructure/code/) using [infrastructure/templates/api.yaml](infrastructure/templates/api.yaml).
5. **Cognito** — user pool `us-east-1_BFXo4Rb0K`, hosted UI domain, identity pool, app client — wired to the API Gateway from (4). See [infrastructure/templates/cognito-agw-auth.template](infrastructure/templates/cognito-agw-auth.template).

After the stacks finish, the script runs two `aws s3 cp` calls to upload [resources/questionnaire.json](resources/questionnaire.json) and [resources/resiliency_resources.json](resources/resiliency_resources.json) into `s3://moralpain-resources-26/` — the `GET` endpoints read these directly.

### Sceptre quirks worth knowing

- Must be invoked **from the `infrastructure/` directory**; paths are relative to `infrastructure/config/`. `./deploy` does the `cd` for you.
- Template bucket `moralpain-templates-26` is auto-created by Sceptre on first run and isn't owned by any CFN stack — that's why [infrastructure/delete](infrastructure/delete) has to delete it manually.

### If a step fails

Re-run with `--launch` — Sceptre and CloudFormation are idempotent and will fast-forward any already-deployed stacks.

Common failures:
- **`Stack ... in ROLLBACK_COMPLETE`** — delete the stack in the CloudFormation console, then rerun.
- **Bucket name already in use** — the `-26` buckets are globally unique S3 names. If another AWS account owns one, you must change the suffix in [infrastructure/deploy](infrastructure/deploy), the Sceptre configs, and the templates.
- **IAM not propagated** — rarely, AWS needs 10–30s for a new role to become usable. Wait and retry.

---

## 2. Verify the deployment

[infrastructure/smoke-test](infrastructure/smoke-test) exercises every endpoint end-to-end: it sends each request **unsigned** and asserts API Gateway returns `403` (confirms SigV4 is actually enforced), then signs the request with your current AWS credentials and asserts `200`. The POST endpoints additionally count S3 objects before/after and assert the count went up by one.

```bash
cd infrastructure
./smoke-test                                                            # auto-detects API URL
./smoke-test https://xxx.execute-api.us-east-1.amazonaws.com/v1         # explicit URL
```

Auto-detection reads the `APIUrl` output of the `moralpain-api` stack via `aws cloudformation describe-stacks`. If smoke-test passes, the backend is working — the app should be able to reach it once a user is provisioned.

You can also spot-check in the AWS console:
- **CloudFormation** — every `moralpain-*` stack is `CREATE_COMPLETE` / `UPDATE_COMPLETE`.
- **API Gateway** — one REST API, four methods, Cognito authorizer attached to all four.
- **Cognito** — user pool `us-east-1_BFXo4Rb0K`, identity pool linked to the user pool, app client with your callback URLs.

---

## 3. Create a Cognito test user

The user pool has no users until you create one. There's no wrapper script — it's two AWS CLI calls:

```bash
POOL=us-east-1_BFXo4Rb0K

aws cognito-idp admin-create-user \
    --user-pool-id "$POOL" \
    --username "$USER@example.com" \
    --user-attributes Name=email,Value="$USER@example.com" Name=email_verified,Value=true \
    --message-action SUPPRESS

aws cognito-idp admin-set-user-password \
    --user-pool-id "$POOL" \
    --username "$USER@example.com" \
    --password '<strong-password>' \
    --permanent
```

`--message-action SUPPRESS` skips the "your temporary password is ..." email; `--permanent` on the password means the user won't be forced to reset on first sign-in.

---

## 4. Run the Flutter app

```bash
cd moraldistress
flutter pub get                                                   # only if you didn't run bin/bootstrap
flutter run -d web-server --web-port 47823 --web-hostname 0.0.0.0
```

Open `http://localhost:47823/` on your host. VS Code auto-forwards the port out of the devcontainer.

### Why port 47823

Cognito's hosted UI only redirects to URLs on the app client's `CallbackURLs` allowlist. The Flutter config in [moraldistress/lib/amplifyconfiguration.dart](moraldistress/lib/amplifyconfiguration.dart) and the Cognito app client are both configured for `http://localhost:47823/` — use that port.

If you need a different port, change it in **both** places:
1. [moraldistress/lib/amplifyconfiguration.dart](moraldistress/lib/amplifyconfiguration.dart) — `SignInRedirectURI` and `SignOutRedirectURI`.
2. The live Cognito app client (fastest) via AWS CLI:
   ```bash
   aws cognito-idp update-user-pool-client \
       --user-pool-id us-east-1_BFXo4Rb0K \
       --client-id 5p9k3kri6rnk46lguj5ff9fhtm \
       --callback-urls 'myapp://' 'https://nicholasphair.github.io/moralpain_dev/' 'http://localhost:<NEW>/' \
       --logout-urls   'myapp://' 'https://nicholasphair.github.io/moralpain_dev/' 'http://localhost:<NEW>/' \
       --allowed-o-auth-flows-user-pool-client \
       --allowed-o-auth-flows code \
       --allowed-o-auth-scopes aws.cognito.signin.user.admin email openid phone profile \
       --supported-identity-providers COGNITO
   ```
   `update-user-pool-client` overwrites the full config, which is why the existing OAuth flags must be re-supplied.
3. Also update [infrastructure/templates/cognito-agw-auth.template](infrastructure/templates/cognito-agw-auth.template) so the next redeploy keeps the change.

### End-to-end sanity check

After signing in and submitting a survey in the UI, the submission should show up in S3:

```bash
aws s3 ls s3://moralpain-submissions-26/surveys/
```

---

## 5. Tear down

[infrastructure/delete](infrastructure/delete) handles the full teardown — Sceptre-managed stacks plus the two buckets CloudFormation won't touch (the `Retain`-policy static-site bucket and the Sceptre-owned template bucket). It also empties versioned-bucket objects and delete markers so CloudFormation can actually delete the buckets.

```bash
cd infrastructure
./delete
```

You'll be prompted for confirmation — the script then:
1. Empties every `moralpain-*-26` bucket (including versions and delete markers).
2. `sceptre delete app` — tears down all CFN stacks.
3. Deletes the two orphan buckets (`moralpain-site-26`, `moralpain-templates-26`).

**Verify in the CloudFormation console** that every stack reaches `DELETE_COMPLETE` — `delete-stack` is async and the script returns before deletion finishes.

**Cognito users:** gone with the user pool.

---

## Troubleshooting

- **Sign-in silently fails** — check the browser console. A callback URL mismatch shows up as `No sign in redirect URLs registered for base URL: ...`.
- **Deploy fails on bucket creation** — a `moralpain-*-26` bucket name is taken in another AWS account; see §1.
- **Flutter build fails with `@staticInterop` errors** — you're on Dart 2.19+; pin Flutter to 3.3.10.
