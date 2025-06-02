resource "local_file" "roles_terraform" {
  for_each = local.org_accounts
  filename = "../roles-terraform/tmp_${each.key}.tf"
  content = templatefile(
    "./templates/terraform-role.tpl",
    {
      account = each.value
      gh_account = "ifbreadgood"
    }
  )
}