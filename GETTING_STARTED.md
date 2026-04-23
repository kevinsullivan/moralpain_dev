# Getting Started

A tour of this repository — a Flutter web app ([moraldistress/](moraldistress/)) that talks to an AWS-backed API ([infrastructure/](infrastructure/)) for the University of Virginia moral-distress reporting project.

For the step-by-step runbook to actually deploy and run the system end-to-end, see **[DEPLOY_MOD.md](DEPLOY_MOD.md)**.

---

## 1. Repo overview

```
api/             OpenAPI-generated Dart + Java clients (sourced from infrastructure/templates/openapi.yaml)
bin/             Bootstrap scripts (flutter pub get, Android emulator helpers)
docs/            Pointer to S3-hosted docs site
external/        Vendored openapi-generator-cli.jar (v7.11.0)
infrastructure/  Sceptre + SAM deploy: CloudFormation/SAM templates, deploy/delete/smoke-test scripts
moraldistress/   The Flutter app (web-only; Flutter 3.3.10, Dart 2.18.6)
resources/       Static JSON seeded into S3 at deploy time (questionnaire.json, resiliency_resources.json)
BUILD.md         Link to hosted docs
README.md        Project intro + copyright
```

### What the app does

The Flutter app authenticates users against a Cognito user pool (hosted UI), then calls a SigV4-signed API Gateway in front of four Lambda endpoints:

- `GET /survey` — proxies the questionnaire JSON from `s3://moralpain-resources-26/questionnaire.json`.
- `POST /survey` — writes a submission to `s3://moralpain-submissions-26/surveys/`.
- `GET /resiliency` — proxies resiliency resources JSON.
- `POST /resiliency` — writes a resiliency selection.

All four endpoints require SigV4 auth (Cognito identity pool → API Gateway). See [infrastructure/templates/openapi.yaml](infrastructure/templates/openapi.yaml) for the contract and [infrastructure/smoke-test](infrastructure/smoke-test) for an executable verification.

### Deploy topology

Deployment is driven by [Sceptre](https://docs.sceptre-project.org/) with a SAM handler. [infrastructure/deploy](infrastructure/deploy) wraps `sceptre create|launch app` and follows it with an `aws s3 cp` to seed the static resources bucket. Stack dependencies (S3 → IAM → SAM API → Cognito) are resolved by Sceptre automatically from [infrastructure/config/app/](infrastructure/config/app/).

### Region and naming

- **AWS region is hardcoded to `us-east-1`** throughout: Sceptre config ([infrastructure/config/config.yaml](infrastructure/config/config.yaml)), the Cognito pool ID in [moraldistress/lib/amplifyconfiguration.dart](moraldistress/lib/amplifyconfiguration.dart), and the generated API's execute-api ARNs.
- **All S3 buckets are suffixed `-26`**: `moralpain-submissions-26`, `moralpain-resources-26`, `moralpain-site-26`, `moralpain-templates-26`, `moralpain-scratch-26`.

---

## 2. Development environment

The fastest path is the **devcontainer** — it pre-installs everything.

### Option A: VS Code devcontainer (recommended)

Open the repo in VS Code and choose *"Reopen in Container"*. [.devcontainer/Dockerfile](.devcontainer/Dockerfile) builds an image with:

| Tool | Version | Notes |
|---|---|---|
| Python | 3.13 | System |
| Java 21 (Corretto) | — | For running `openapi-generator-cli.jar` and Maven Lambda builds |
| Maven | latest | Java Lambda packaging |
| Flutter | **3.3.10** | Pinned; see [.devcontainer/Dockerfile:9](.devcontainer/Dockerfile#L9) |
| Dart | 2.18.6 | Bundled with Flutter |
| AWS CLI | v2 | User-local install |
| AWS SAM | 1.133.0 | User-local install |
| Sceptre | 3.x + `sceptre-sam-handler==0.3.1` | pip |
| yq, gh, git-lfs, graphviz | — | System |

`postCreateCommand` runs [bin/bootstrap](bin/bootstrap) automatically, which does `flutter pub get` in both [moraldistress/](moraldistress/) and [api/dart/](api/dart/). First-run can take several minutes because Flutter does a `git fetch --tags` against the pinned SDK clone.

> ⚠ **Don't bump Flutter past 3.3.10.** The app pins Dart `>=2.17.0 <3.0.0`, and the Amplify 1.0.0-next preview line uses a `@staticInterop`/`external` pattern that Dart 2.19 disallows. 3.3.10 (Dart 2.18.6) is the newest stable tooling the code compiles under.

### Option B: Manual install

If you're not using the devcontainer, install the tools above yourself. The non-obvious ones:

```bash
# Flutter 3.3.10 (pin to match; newer will not compile the Amplify preview)
git clone https://github.com/flutter/flutter.git -b 3.3.10 ~/flutter
export PATH="$HOME/flutter/bin:$PATH"
flutter --version                          # expect Flutter 3.3.10 / Dart 2.18.6

# AWS tooling
# - AWS CLI v2:     https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# - AWS SAM:        https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html
# - Sceptre 3.x:    pip install 'sceptre>=3,<4' 'sceptre-sam-handler==0.3.1'

# Then run the repo bootstrap
./bin/bootstrap
```

You'll also need valid AWS credentials on your shell (`aws sts get-caller-identity` must succeed) to deploy or smoke-test.

---

## 3. Repo-local packages and clients

### [api/](api/)
OpenAPI-generated clients. Both are regenerated from [infrastructure/templates/openapi.yaml](infrastructure/templates/openapi.yaml) via [external/openapi-generator-cli.jar](external/openapi-generator-cli.jar). Regeneration is manual — there's no git hook. The Dart client is consumed by the Flutter app as a path dependency.

### [moraldistress/packages/](moraldistress/packages/)
Three local Dart packages the Flutter app depends on via `path:`:
- `cognito_authentication_repository/` — thin wrapper over `amplify_auth_cognito` exposing `signInPrivateSession`, `isAuthenticated`, `isAuthorized`, `fetchUserCredentials`.
- `aws_signature_v4_interceptor/` — Dio interceptor that signs outbound API Gateway requests with SigV4 using the current Cognito session credentials.
- `uva_themed_widgets/` — custom UI components.

### [moraldistress/lib/amplifyconfiguration.dart](moraldistress/lib/amplifyconfiguration.dart)
Hard-coded Cognito + OAuth config:
- User Pool: `us-east-1_BFXo4Rb0K`
- App Client: `5p9k3kri6rnk46lguj5ff9fhtm`
- Hosted UI domain: `moralpain-user-pool-domain.auth.us-east-1.amazoncognito.com`
- OAuth callback URIs: `http://localhost:47823/`, `https://nicholasphair.github.io/moralpain_dev/`, `myapp://`

Any changes here must be mirrored in the Cognito app client's `CallbackURLs`/`LogoutURLs` — either in the AWS console or in [infrastructure/templates/cognito-agw-auth.template](infrastructure/templates/cognito-agw-auth.template) followed by a redeploy.

---

## 4. What to read next

- **Deploying the backend end-to-end:** [DEPLOY_MOD.md](DEPLOY_MOD.md).
- **Infrastructure internals:** [infrastructure/README.md](infrastructure/README.md).
- **API contract:** [infrastructure/templates/openapi.yaml](infrastructure/templates/openapi.yaml).
- **Smoke-testing a live deployment:** [infrastructure/smoke-test](infrastructure/smoke-test) (header comment documents usage).
