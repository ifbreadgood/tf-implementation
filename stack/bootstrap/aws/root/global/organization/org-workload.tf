resource "aws_organizations_organizational_unit" "workload" {
  name      = "workload"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "workload_prod" {
  name      = "prod"
  parent_id = aws_organizations_organizational_unit.workload.id
}

# resource "aws_organizations_account" "workload_prod" {
#   email = "ifbread+workload-prod@pm.me"
#   name  = "workload-prod"
#   close_on_deletion = true
#   parent_id = aws_organizations_organizational_unit.workload_prod.id
# }

resource "aws_organizations_organizational_unit" "workload_test" {
  name      = "test"
  parent_id = aws_organizations_organizational_unit.workload.id
}

resource "aws_organizations_account" "workload_test" {
  email = "ifbread+workload-test@pm.me"
  name  = "workload-test"
  close_on_deletion = true
  parent_id = aws_organizations_organizational_unit.workload_test.id
}