terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "account.amazonaws.com",
    "sso.amazonaws.com",
    "iam.amazonaws.com"
  ]
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "RESOURCE_CONTROL_POLICY"
  ]
  feature_set = "ALL"
}