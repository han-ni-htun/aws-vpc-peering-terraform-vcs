# Define Terraform and provider versions for frontend EC2 infrastructure.
terraform {
  required_version = "~> 1.16.6"

  # Store frontend compute state in its dedicated HCP Terraform workspace.
  cloud {
    organization = "han-cloud"

    workspaces {
      name = "fe-compute-vcs-ws"
    }
  }

  # Use the AWS provider for EC2 infrastructure management.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
