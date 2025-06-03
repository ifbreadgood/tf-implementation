resource "aws_organizations_organizational_unit" "infrastructure" {
  name      = "infrastructure"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_account" "infrastructure_shared" {
  email = "ifbread+infrastructure-shared@pm.me"
  name  = "shared"
  close_on_deletion = true
  parent_id = aws_organizations_organizational_unit.infrastructure.id
}

resource "aws_organizations_organizational_unit" "infrastructure_prod" {
  name      = "prod"
  parent_id = aws_organizations_organizational_unit.infrastructure.id
}

resource "aws_organizations_account" "identity" {
  email = "ifbread+identity@pm.me"
  name  = "identity"
  close_on_deletion = true
  parent_id = aws_organizations_organizational_unit.infrastructure.id
}

resource "aws_organizations_delegated_administrator" "sso" {
  account_id        = aws_organizations_account.identity.id
  service_principal = "sso.amazonaws.com"
}

resource "aws_organizations_delegated_administrator" "iam" {
  account_id        = aws_organizations_account.identity.id
  service_principal = "iam.amazonaws.com"
}

# resource "aws_organizations_account" "infrastructure_prod" {
#   email = "ifbread+infrastructure-prod@pm.me"
#   name  = "infrastructure-prod"
#   close_on_deletion = true
#   parent_id = aws_organizations_organizational_unit.infrastructure_prod.id
# }

resource "aws_organizations_organizational_unit" "infrastructure_test" {
  name      = "test"
  parent_id = aws_organizations_organizational_unit.infrastructure.id
}

resource "aws_organizations_account" "infrastructure_test" {
  email = "ifbread+network-test@pm.me"
  name  = "network-test"
  close_on_deletion = true
  parent_id = aws_organizations_organizational_unit.infrastructure_test.id
}