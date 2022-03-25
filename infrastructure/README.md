# infrastructure

## Requirements
The following packages are required to deploy the infrastructure. Follow
the links below to the appropriate installation documentation.
+ [AWS CLI][1]
+ [AWS SAM][2]
+ [Sceptre][3]

## Deployment
Most resources in this directry are deployed using CloudFormation and Sceptre.
For the API and corresponding Lambdas, deployment is done with SAM. This is
mainly to levarage SAM's support for packaging the Lambda code and its testing
framework. While SAM resources currently have their own deployment workflow,
Sceptre and SAM can actually [operate together][4]. We hope to migrate over to
this pattern soon.

### Sceptre
```bash
sceptre create <path/to/config.yaml>
```

Please be aware that the Sceptre CLI usage is a little clumsy. The path to the
config file is expected to be relative to the `config` direcory. However, the
command itself needs to be run from the `infrastrucure` directory. Rephrased,
the config path is relative, but not relative to the directory you are running
the command from. Below is an example of creating a resource with Sceptre.
```bash
sceptre create iam/users/dknuth.yaml
```


### SAM
```bash
cd sam
sam build
sam deploy
```

[1]: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
[2]: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html
[3]: https://docs.sceptre-project.org/latest/docs/install.html
[4]: https://docs.sceptre-project.org/latest/docs/faq.html#how-do-i-build-a-serverless-application-using-sceptre-and-sam
