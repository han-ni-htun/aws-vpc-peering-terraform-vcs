
# Read the current frontend networking outputs from HCP Terraform.
# Access is restricted by the frontend workspace's state-sharing settings.
data "terraform_remote_state" "frontend" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "fe-network-vcs-ws"
    }
  }
}
