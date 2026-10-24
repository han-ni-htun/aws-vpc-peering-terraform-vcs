# Retrieve backend Security Group IDs from the dedicated HCP Terraform workspace.
# These outputs support controlled cross-VPC Security Group references.
data "terraform_remote_state" "backend_security" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "be-security-vcs-ws"
    }
  }
}
