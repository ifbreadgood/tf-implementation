provider "aws" {
  alias = "account_${account}"
  region = "us-east-2"
  assume_role {
    role_arn = "arn:aws:iam::${account}:role/OrganizationAccountAccessRole"
  }
}

resource "aws_iam_openid_connect_provider" "gha_${account}" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com",]
  provider = aws.account_${account}
}

resource "aws_iam_role" "gha_${account}" {
  name = "github-actions"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${account}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : "repo:${gh_account}/tf-implementation:*"
          },
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com",
          }
        }
      }
    ]
  })
  provider = aws.account_${account}
}

resource "aws_iam_role_policy_attachment" "gha_${account}" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role       = aws_iam_role.gha_${account}.name
  provider = aws.account_${account}
}