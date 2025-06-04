terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99.0"
    }
  }
  required_version = "~> 1.12.0"
}

provider "aws" {
  default_tags {
    tags = var.tags
  }
}

variable "tags" {
  type = map(string)
}

locals {
  base_subnet     = "10.1.0.0/16"
  public_subnets  = cidrsubnets(cidrsubnet(local.base_subnet, 1, 0), 7, 7, 7)
  private_subnets = cidrsubnets(cidrsubnet(local.base_subnet, 1, 1), 7, 7, 7)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "default"
  cidr = local.base_subnet

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false

  create_database_subnet_group       = true
  create_database_subnet_route_table = true
}