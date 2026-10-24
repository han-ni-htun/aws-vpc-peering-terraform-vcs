# Define the security boundary for backend public EC2 instance 01.
# Restrict inbound SSH and ICMP access to the administrator's public IP.
resource "aws_security_group" "be_public_01" {
  name        = "be-public-sg-01"
  description = "Security group for backend public instance 01."
  vpc_id      = data.terraform_remote_state.backend_network.outputs.backend_vpc_id

  tags = {
    Name = "be-public-sg-01"
  }
}

# Define the security boundary for backend private EC2 instance 01.
# Restrict inbound SSH and ICMP access to the backend public security group.
resource "aws_security_group" "be_private_01" {
  name        = "be-private-sg-01"
  description = "Security group for backend private instance 01."
  vpc_id      = data.terraform_remote_state.backend_network.outputs.backend_vpc_id

  tags = {
    Name = "be-private-sg-01"
  }
}

# Define the security boundary for backend private EC2 instance 02.
# Restrict SSH and ICMP access to authorized local and peered VPC sources.
resource "aws_security_group" "be_private_02" {
  name        = "be-private-sg-02"
  description = "Security group for backend private instance 02."
  vpc_id      = data.terraform_remote_state.backend_network.outputs.backend_vpc_id

  tags = {
    Name = "be-private-sg-02"
  }
}

# Define the security boundary for backend private EC2 instance 03.
# Restrict SSH and ICMP access to authorized local and peered VPC sources.
resource "aws_security_group" "be_private_03" {
  name        = "be-private-sg-03"
  description = "Security group for backend private instance 03."
  vpc_id      = data.terraform_remote_state.backend_network.outputs.backend_vpc_id

  tags = {
    Name = "be-private-sg-03"
  }
}
