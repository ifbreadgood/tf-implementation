resource "aws_organizations_policy" "deny_leave_org" {
  name    = "DenyLeaveOrg"
  content = jsonencode({
    "Version": "2012-10-17",
    "Statement" : [
      {
        "Sid": "DenyLeaveOrg",
        "Effect": "Deny",
        "Action": "organizations:LeaveOrganization",
        "Resource": "*",
      }
    ]
  })

}

resource "aws_organizations_policy_attachment" "deny_leave_org" {
  policy_id = aws_organizations_policy.deny_leave_org.id
  target_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_policy" "deny_member_account_instances" {
  name    = "DenyMemberAccountInstances"
  content = jsonencode({
    "Version": "2012-10-17",
    "Statement" : [
      {
        "Sid": "DenyMemberAccountInstances",
        "Effect": "Deny",
        "Action": "sso:CreateInstance",
        "Resource": "*",
        "Condition": {
          "StringNotEquals": {
            "aws:PrincipalAccount": [aws_organizations_account.identity.id]
          }
        }
      }
    ]
  })
}

resource "aws_organizations_policy_attachment" "deny_member_account_instances" {
  policy_id = aws_organizations_policy.deny_member_account_instances.id
  target_id = aws_organizations_organization.org.roots[0].id
}