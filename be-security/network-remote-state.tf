# Read the backend VPC ID from its HCP Terraform networking workspace.
# This avoids hardcoding an AWS-generated VPC ID.
data "terraform_remote_state" "backend_network" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "be-network-vcs-ws"
    }
  }
}
