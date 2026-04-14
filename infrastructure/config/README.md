# Sceptre Config

This directory contains all CloudFormation stack configurations managed by
[Sceptre](https://docs.sceptre-project.org/). Project-wide settings live in
[config.yaml](config.yaml).

The configs are split into two top-level groups, deployed independently:

| Directory | Contents | When to deploy |
|---|---|---|
| [app/](app/) | The MoralPain application: S3 buckets, IAM policies/roles, the SAM API, and Cognito | Every code change; this is what `sceptre create app` deploys |
| [bootstrap/](bootstrap/) | One-time setup: GitHub OIDC providers for CI/CD and individual IAM user accounts | Once per AWS account, or when adding/removing contributors |

## Deploying

```bash
cd infrastructure

# Deploy the application
sceptre create app

# Deploy bootstrap pieces individually as needed
sceptre create bootstrap/github/oidc-provider-nicholasphair.yaml
sceptre create bootstrap/users/nphair.yaml
```

Stack names follow the pattern `moralpain-{path-with-dashes}`, e.g.
`app/api/api.yaml` becomes `moralpain-api` (overridden via `stack_name`)
and `app/s3/template-bucket.yaml` becomes `moralpain-app-s3-template-bucket`.
