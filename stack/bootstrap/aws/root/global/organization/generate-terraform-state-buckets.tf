resource "local_file" "state_terraform" {
  for_each = local.org_accounts
  filename = "../s3/member-account-tfstate/tmp_${each.key}.tf"
  content = templatefile(
    "./templates/terraform-state.tpl",
    {
      account = each.value
      module_version = "73b4a113ffa3a50fc94a6b11b6e154ac7fa1ff9d"
    }
  )
}