resource "local_file" "roles_terraform" {
  for_each = {for account in [
    aws_organizations_account.identity,
    aws_organizations_account.workload_test,
    aws_organizations_account.infrastructure_test
  ]: account.name => account.id}
  filename = "../roles-terraform/tmp_${each.key}.tf"
  content = templatefile(
    "./templates/terraform-role.tpl",
    {
      account = each.value
      gh_account = "ifbreadgood"
    }
  )
}