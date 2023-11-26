terraform {
  required_version = "~> 1.6.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
  cloud {
    organization = "krlab"

    workspaces {
      name = "clidriven"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}

module "mymod" {
  count = 2
  source  = "app.terraform.io/krlab/mytfmod/aws"
  version = "1.0.0"
  ec2_type = "t2.micro"
  ec2_tags = {Name = "myapp${count.index}", environment = "development"}
}
output "public_ip" {
  value = module.mymod[*].instance_public_ip
}