const amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
      "plugins": {
        "awsCognitoAuthPlugin": {
          "UserAgent": "aws-amplify-cli/0.1.0",
          "Version": "0.1.0",
          "IdentityManager": {
            "Default": {}
          },
          "CredentialsProvider": {
            "CognitoIdentity": {
              "Default": {
                "PoolId": "us-east-1:15780a00-0b24-4d31-ae88-ac5e6df4b673",
                "Region": "us-east-1"
              }
            }
          },
          "CognitoUserPool": {
            "Default": {
              "PoolId": "us-east-1_BFXo4Rb0K",
              "AppClientId": "5p9k3kri6rnk46lguj5ff9fhtm",
              "Region": "us-east-1"
            }
          },
          "Auth": {
            "Default": {
              "OAuth": {
                "WebDomain": "moralpain-user-pool-domain.auth.us-east-1.amazoncognito.com",
                "AppClientId": "5p9k3kri6rnk46lguj5ff9fhtm",
                "SignInRedirectURI": "myapp://,http://localhost:3000/,https://nicholasphair.github.io/moralpain_dev/",
                "SignOutRedirectURI": "myapp://,http://localhost:3000/,https://nicholasphair.github.io/moralpain_dev/",
                "Scopes": [
                  "phone",
                "email",
                "openid",
                "profile",
                "aws.cognito.signin.user.admin"
                ]
              },
              "authenticationFlowType": "USER_SRP_AUTH",
              "socialProviders": [],
              "usernameAttributes": [],
              "signupAttributes": [
                "EMAIL",
                "NAME"
              ],
              "passwordProtectionSettings": {
                "passwordPolicyMinLength": 8,
                "passwordPolicyCharacters": []
              },
              "mfaConfiguration": "OFF",
              "mfaTypes": [
                "SMS"
              ],
              "verificationMechanisms": [
                "EMAIL"
              ]
            }
          }
        }
      }
    }
}''';
