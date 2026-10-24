# Discover the latest official Amazon Linux 2023 x86_64 image.
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Discover the latest official Ubuntu 24.04 LTS x86_64 image.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Register the administrator's public SSH key for backend EC2 access.
resource "aws_key_pair" "backend" {
  key_name   = "be-vpc-peering-key"
  public_key = var.ssh_public_key

  tags = {
    Name = "be-vpc-peering-key"
  }
}

# Deploy the backend public instance as the SSH entry point.
resource "aws_instance" "be_public_01" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.backend_network.outputs.backend_subnet_ids.public_01
  vpc_security_group_ids      = [data.terraform_remote_state.backend_security.outputs.backend_security_group_ids.public_01]
  key_name                    = aws_key_pair.backend.key_name
  associate_public_ip_address = true

  # Require IMDSv2 for instance metadata access.
  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "be-public-ec2-01"
  }
}

# Associate backend private instances with their matching subnets and security groups.
locals {
  backend_private_instances = {
    "01" = {
      subnet_id         = data.terraform_remote_state.backend_network.outputs.backend_subnet_ids.private_01
      security_group_id = data.terraform_remote_state.backend_security.outputs.backend_security_group_ids.private_01
    }
    "02" = {
      subnet_id         = data.terraform_remote_state.backend_network.outputs.backend_subnet_ids.private_02
      security_group_id = data.terraform_remote_state.backend_security.outputs.backend_security_group_ids.private_02
    }
    "03" = {
      subnet_id         = data.terraform_remote_state.backend_network.outputs.backend_subnet_ids.private_03
      security_group_id = data.terraform_remote_state.backend_security.outputs.backend_security_group_ids.private_03
    }
  }
}

# Deploy one Ubuntu instance in each backend private subnet.
resource "aws_instance" "be_private" {
  for_each = local.backend_private_instances

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = each.value.subnet_id
  vpc_security_group_ids      = [each.value.security_group_id]
  key_name                    = aws_key_pair.backend.key_name
  associate_public_ip_address = false

  # Require IMDSv2 for instance metadata access.
  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "be-private-ec2-${each.key}"
  }
}
