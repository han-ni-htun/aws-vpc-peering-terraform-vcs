# Read frontend subnet and networking outputs from its network workspace.
data "terraform_remote_state" "frontend_network" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "fe-network-vcs-ws"
    }
  }
}

# Read frontend Security Group IDs from its security workspace.
data "terraform_remote_state" "frontend_security" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "fe-security-vcs-ws"
    }
  }
}
