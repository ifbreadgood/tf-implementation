include "backend" {
  path = find_in_parent_folders("aws-backend.hcl")
}

terraform {
  source = "github.com/ifbreadgood/tf-module-github.git//repository?ref=29762e7b5439f11e59d47c2b66329310e886c73b"
}

inputs = {
  name       = "tf-module-vault"
  visibility = "public"
  # team_collaborators = {
  #   admin = ["admin"]
  #   maintain = ["devops"]
  #   pull = ["engineers"]
  # }
}
