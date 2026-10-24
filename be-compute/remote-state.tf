# Read backend subnet and networking outputs from its network workspace.
data "terraform_remote_state" "backend_network" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "be-network-vcs-ws"
    }
  }
}

# Read backend Security Group IDs from its security workspace.
data "terraform_remote_state" "backend_security" {
  backend = "remote"

  config = {
    organization = "han-cloud"

    workspaces = {
      name = "be-security-vcs-ws"
    }
  }
}
