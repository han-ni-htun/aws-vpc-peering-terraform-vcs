# Read the frontend VPC ID from its HCP Terraform networking workspace.
# This avoids hardcoding an AWS-generated VPC ID.
data "terraform_remote_state" "frontend_network" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "fe-network-vcs-ws"
    }
  }
}
