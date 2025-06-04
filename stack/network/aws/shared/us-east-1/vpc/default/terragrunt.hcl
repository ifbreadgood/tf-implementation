include "backend" {
  path = find_in_parent_folders("aws-backend.hcl")
  expose = true
}

inputs = {
  tags = jsonencode(include.backend.locals.default_tags)
}

terraform {
  extra_arguments "destroy" {
    commands = ["apply"]
    arguments = ["-destroy"]
  }
}