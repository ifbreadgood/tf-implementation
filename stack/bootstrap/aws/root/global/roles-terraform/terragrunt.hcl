include "backend" {
  path = find_in_parent_folders("aws-backend.hcl")
}

dependencies {
  paths = ["../organization"]
}