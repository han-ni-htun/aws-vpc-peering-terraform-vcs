# Define the security boundary for frontend public EC2 instance 01.
# Restrict inbound SSH and ICMP access to the administrator's public IP.
resource "aws_security_group" "fe_public_01" {
  name        = "fe-public-sg-01"
  description = "Security group for frontend public instance 01."
  vpc_id      = data.terraform_remote_state.frontend_network.outputs.frontend_vpc_id

  tags = {
    Name = "fe-public-sg-01"
  }
}

# Define the security boundary for frontend private EC2 instance 01.
# Restrict inbound SSH and ICMP access to the frontend public security group.
resource "aws_security_group" "fe_private_01" {
  name        = "fe-private-sg-01"
  description = "Security group for frontend private instance 01."
  vpc_id      = data.terraform_remote_state.frontend_network.outputs.frontend_vpc_id

  tags = {
    Name = "fe-private-sg-01"
  }
}

# Define the security boundary for frontend private EC2 instance 02.
# Restrict SSH and ICMP access to authorized local and peered VPC sources.
resource "aws_security_group" "fe_private_02" {
  name        = "fe-private-sg-02"
  description = "Security group for frontend private instance 02."
  vpc_id      = data.terraform_remote_state.frontend_network.outputs.frontend_vpc_id

  tags = {
    Name = "fe-private-sg-02"
  }
}

# Define the security boundary for frontend private EC2 instance 03.
# Restrict SSH and ICMP access to authorized local and peered VPC sources.
resource "aws_security_group" "fe_private_03" {
  name        = "fe-private-sg-03"
  description = "Security group for frontend private instance 03."
  vpc_id      = data.terraform_remote_state.frontend_network.outputs.frontend_vpc_id

  tags = {
    Name = "fe-private-sg-03"
  }
}
