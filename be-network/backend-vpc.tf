# Allocate a non-overlapping private address space for the backend VPC.
# DNS support enables private hostname resolution for EC2 instances.
resource "aws_vpc" "backend" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "be-vpc"
  }
}
