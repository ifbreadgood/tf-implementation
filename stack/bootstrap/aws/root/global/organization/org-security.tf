resource "aws_organizations_organizational_unit" "security" {
  name      = "security"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "security_prod" {
  name      = "prod"
  parent_id = aws_organizations_organizational_unit.security.id
}

# resource "aws_organizations_account" "security_prod" {
#   email = "ifbread+security-prod@pm.me"
#   name  = "security-prod"
#   close_on_deletion = true
#   parent_id = aws_organizations_organizational_unit.security_prod.id
# }

resource "aws_organizations_organizational_unit" "security_test" {
  name      = "test"
  parent_id = aws_organizations_organizational_unit.security.id
}

# resource "aws_organizations_account" "security_test" {
#   email = "ifbread+security-test@pm.me"
#   name  = "security-test"
#   close_on_deletion = true
#   parent_id = aws_organizations_organizational_unit.security_test.id
# }