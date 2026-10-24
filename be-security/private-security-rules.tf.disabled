
# Define permitted SSH and ICMP protocols for private instances.
locals {
  private_protocols = {
    ssh = {
      protocol  = "tcp"
      from_port = 22
      to_port   = 22
    }
    icmp = {
      protocol  = "icmp"
      from_port = 8
      to_port   = 0
    }
  }

  # Associate each backend private group with its corresponding frontend peer.
  private_peer_groups = {
    "02" = {
      local_id = aws_security_group.be_private_02.id
      peer_id  = data.terraform_remote_state.frontend_security.outputs.frontend_security_group_ids.private_02
    }
    "03" = {
      local_id = aws_security_group.be_private_03.id
      peer_id  = data.terraform_remote_state.frontend_security.outputs.frontend_security_group_ids.private_03
    }
  }

  # Expand the private group and protocol combinations into individual rules.
  private_peer_rules = {
    for pair in setproduct(keys(local.private_peer_groups), keys(local.private_protocols)) :
    "${pair[0]}_${pair[1]}" => {
      local_id  = local.private_peer_groups[pair[0]].local_id
      peer_id   = local.private_peer_groups[pair[0]].peer_id
      protocol  = local.private_protocols[pair[1]].protocol
      from_port = local.private_protocols[pair[1]].from_port
      to_port   = local.private_protocols[pair[1]].to_port
    }
  }
}

# Permit SSH and ICMP from the backend public instance to private instance 01.
resource "aws_vpc_security_group_ingress_rule" "be_private_01_from_public" {
  for_each = local.private_protocols

  security_group_id            = aws_security_group.be_private_01.id
  referenced_security_group_id = aws_security_group.be_public_01.id
  description                  = "Allow ${each.key} from backend public instance."

  ip_protocol = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}

# Allow unrestricted outbound IPv4 traffic from backend private instance 01.
resource "aws_vpc_security_group_egress_rule" "be_private_01_all" {
  security_group_id = aws_security_group.be_private_01.id
  description       = "Allow all outbound IPv4 traffic."

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Permit SSH and ICMP from backend private instance 01 to private instances 02 and 03.
resource "aws_vpc_security_group_ingress_rule" "be_private_from_private_01" {
  for_each = local.private_peer_rules

  security_group_id            = each.value.local_id
  referenced_security_group_id = aws_security_group.be_private_01.id
  description                  = "Allow approved traffic from backend private instance 01."

  ip_protocol = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}

# Permit SSH and ICMP from matching frontend private instances over VPC peering.
resource "aws_vpc_security_group_ingress_rule" "be_private_from_frontend" {
  for_each = local.private_peer_rules

  security_group_id            = each.value.local_id
  referenced_security_group_id = each.value.peer_id
  description                  = "Allow approved traffic from matching frontend private instance."

  ip_protocol = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}

# Restrict outbound SSH and ICMP to matching frontend private instances.
resource "aws_vpc_security_group_egress_rule" "be_private_to_frontend" {
  for_each = local.private_peer_rules

  security_group_id            = each.value.local_id
  referenced_security_group_id = each.value.peer_id
  description                  = "Allow approved traffic to matching frontend private instance."

  ip_protocol = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}
