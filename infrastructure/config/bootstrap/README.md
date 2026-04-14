# Bootstrap Stacks

One-time setup that doesn't change with the application. Deploy these
individually when you need them — they are **not** included in
`sceptre create app`.

## Layout

| Directory | What it contains | When to deploy |
|---|---|---|
| [github/](github/) | OIDC providers and roles allowing GitHub Actions to assume AWS roles for CI/CD | Once per AWS account, plus when adding a new contributor's repo |
| [users/](users/) | Individual IAM user accounts for human team members | When adding or removing a team member |
| [iam/policies/](iam/policies/) | The CICD documentation-write policy used by the GitHub OIDC roles | Auto-deployed when you create a GitHub OIDC stack (via `!stack_output`) |

## Deploying

```bash
# First-time setup: deploy the OIDC provider stack for the repo owner.
# (This stack also creates the OIDC provider resource that the others reuse.)
sceptre create bootstrap/github/oidc-provider-nicholasphair.yaml

# Then any additional contributor stacks
sceptre create bootstrap/github/oidc-provider-arh4uwe.yaml
sceptre create bootstrap/github/oidc-provider-kevinsullivan.yaml

# IAM users — deploy one per team member
sceptre create bootstrap/users/nphair.yaml
```

## Notes

- The first GitHub OIDC stack you deploy is the one that *creates* the
  `AWS::IAM::OIDCProvider` resource. The other stacks consume its ARN via
  `!stack_output`, so deploy `oidc-provider-nicholasphair.yaml` first.
- After the OIDC providers exist, store the resulting role ARN as the
  `AWS_ACCOUNT_ID` GitHub Actions secret on the repository so the workflows
  in `.github/workflows/` can authenticate.
