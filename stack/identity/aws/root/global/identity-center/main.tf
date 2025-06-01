terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
  required_version = "~> 1.12.0"
}

provider "aws" {
  region = "us-east-1"
  # assume_role {
  #   role_arn = "arn:aws:iam::925697179472:role/OrganizationAccountAccessRole"
  # }
}

data "aws_ssoadmin_instances" "this" {}

locals {
  instance_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  instance_store_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}

resource "aws_identitystore_group" "power" {
  display_name      = "power"
  identity_store_id = local.instance_store_id
}

resource "aws_identitystore_group_membership" "power" {
  group_id          = aws_identitystore_group.power.group_id
  identity_store_id = local.instance_store_id
  member_id         = aws_identitystore_user.terraform.user_id
}

resource "aws_identitystore_user" "terraform" {
  identity_store_id = local.instance_store_id

  display_name = "terraform"
  user_name    = "terraform"

  name {
    given_name  = "terra"
    family_name = "form"
  }

  emails {
    value = "ifbread+aws-terraform@pm.me"
  }
}

resource "aws_ssoadmin_permission_set" "power" {
  instance_arn = local.instance_store_arn
  name         = "PowerUser"
}

resource "aws_ssoadmin_managed_policy_attachment" "power" {
  instance_arn       = local.instance_store_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  permission_set_arn = aws_ssoadmin_permission_set.power.arn
}

data "aws_organizations_organization" "org" {}

data "aws_organizations_organizational_unit_descendant_accounts" "accounts" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

resource "aws_ssoadmin_account_assignment" "power" {
  for_each = toset([for account in data.aws_organizations_organizational_unit_descendant_accounts.accounts.accounts: account.id if account.name != "ibcngn"])
  instance_arn       = local.instance_store_arn
  permission_set_arn = aws_ssoadmin_permission_set.power.arn
  principal_id       = aws_identitystore_group.power.group_id
  principal_type     = "GROUP"
  target_id          = each.value
  target_type = "AWS_ACCOUNT"
}