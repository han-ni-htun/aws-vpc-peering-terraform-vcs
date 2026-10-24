# Permit SSH access to the backend public instance from the trusted administrator.
resource "aws_vpc_security_group_ingress_rule" "be_public_ssh" {
  security_group_id = aws_security_group.be_public_01.id
  description       = "Allow SSH from the trusted administrator."

  cidr_ipv4   = var.admin_cidr
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

# Permit ICMP Echo Requests from the trusted administrator for connectivity testing.
resource "aws_vpc_security_group_ingress_rule" "be_public_icmp" {
  security_group_id = aws_security_group.be_public_01.id
  description       = "Allow ICMP Echo Requests from the trusted administrator."

  cidr_ipv4   = var.admin_cidr
  ip_protocol = "icmp"
  from_port   = 8
  to_port     = 0
}

# Allow outbound traffic from the backend public instance.
resource "aws_vpc_security_group_egress_rule" "be_public_all" {
  security_group_id = aws_security_group.be_public_01.id
  description       = "Allow all outbound IPv4 traffic."

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
