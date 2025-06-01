terraform {
  required_version = "~> 1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_caller_identity" "this" {}

resource "aws_iam_openid_connect_provider" "gha" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com",]
}

resource "aws_iam_role" "gha" {
  name = "github-actions"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com",
            "token.actions.githubusercontent.com:sub" : "repo:ifbreadgood/tf-implementation:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "gha" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role       = aws_iam_role.gha.name
}