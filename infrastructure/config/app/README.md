# Application Stacks

These are the CloudFormation stacks that make up the MoralPain application.
Sceptre resolves the dependency graph automatically from `!stack_output`
references, so you can deploy everything at once:

```bash
sceptre create app
```

## Layout

| Directory | What it contains |
|---|---|
| [s3/](s3/) | S3 buckets: `moralpain-submissions`, `moralpain-resources`, `moralpain-site`, `moralpain-templates`, `moralpain-scratch` |
| [iam/policies/](iam/policies/) | Managed IAM policies attached to the Lambda and API Gateway service roles |
| [iam/roles/](iam/roles/) | IAM roles assumed by Lambdas (per function) and by API Gateway (per integration) |
| [api/](api/) | The SAM stack that builds and deploys the API Gateway + all Lambda functions |
| [cognito/](cognito/) | Cognito user/identity pools plus the two invocation roles attached to the identity pool |

## Deployment Order (resolved automatically)

1. **S3 buckets** + **IAM policies** — no dependencies, deploy in parallel
2. **IAM roles** — depend on policies via `!stack_output`
3. **SAM API** — depends on the template bucket; references IAM roles by hardcoded name (must already exist)
4. **Cognito** — depends on the API URI plus the admin/unauthenticated invocation policies

## Notes

- The SAM stack uses `stack_name: moralpain-api` to keep the CloudFormation
  stack name short instead of the default `moralpain-app-api-api`.
- Lambda functions reference IAM roles by hardcoded ARN
  (`arn:aws:iam::${AWS::AccountId}:role/lambda_submit_survey_role`), not via
  `!stack_output`. The role name must match the `Name` parameter in the
  corresponding role config.
