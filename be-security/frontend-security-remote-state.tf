# Retrieve frontend Security Group IDs from the dedicated HCP Terraform workspace.
# These outputs support controlled cross-VPC Security Group references.
data "terraform_remote_state" "frontend_security" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "fe-security-vcs-ws"
    }
  }
}
