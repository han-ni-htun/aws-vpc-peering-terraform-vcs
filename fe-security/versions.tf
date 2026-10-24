terraform {
  required_version = "~> 1.16.6"

  # Store frontend Security Group state in its own HCP Terraform workspace.
  # Plans and applies execute remotely.
  cloud {
    organization = "han-cloud"

    workspaces {
      name = "fe-security-vcs-ws"
    }
  }

  # Use the AWS provider to manage security groups and their rules.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
