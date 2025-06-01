generate "tflint" {
  path      = ".tflint.hcl"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    plugin "terraform" {
      enabled = true
      preset  = "recommended"
    }

    plugin "aws" {
      enabled = true
      version = "0.36.0"
      source  = "github.com/terraform-linters/tflint-ruleset-aws"
    }
    EOF
}