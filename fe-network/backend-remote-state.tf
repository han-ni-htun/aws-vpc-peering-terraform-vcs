# Read the backend networking outputs from HCP Terraform.
data "terraform_remote_state" "backend" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "be-network-vcs-ws"
    }
  }
}
