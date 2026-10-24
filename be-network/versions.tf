
terraform {
  required_version = "~> 1.16.6"

  # Centralize state management and locking in HCP Terraform.
  # Plans and applies run remotely when workspace execution mode is Remote.
  cloud {
    organization = "han-cloud"

    workspaces {
      name = "be-network-vcs-ws"
    }
  }

  required_providers {
    # Manage backend VPC networking resources in AWS.
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
