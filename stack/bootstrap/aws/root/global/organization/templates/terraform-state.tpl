module "state_${account}" {
  source = "git::git@github.com:ifbreadgood/tf-module-aws.git//terraform-state?ref=${module_version}"
  name = "tf-state"
  provider_assume_role_arn = "arn:aws:iam::${account}:role/OrganizationAccountAccessRole"
  tags = {
    managed-by = "terraform"
  }
}