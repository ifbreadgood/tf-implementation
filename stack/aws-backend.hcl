locals {
  path = regex("(?P<project>[^/]+)/(?P<platform>[^/]+)/(?P<environment>[^/]+)/(?P<location>[^/]+)/(?P<resource>[^/]+).*", path_relative_to_include())
  location = local.path.location
  project = local.path.project
  platform = local.path.platform
  environment = local.path.environment
  resource = local.path.resource
  default_tags = {
    location = local.location
    project = local.project
    platform = local.platform
    environment = local.environment
    resource = local.resource
  }
}

generate "backend" {
  path      = "_backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      backend "s3" {
        region         = "us-east-2"
        bucket         = "tf-state-${get_aws_account_id()}-primary"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        encrypt        = true
        use_lockfile   = true
      }
    }
    EOF
}