# Allocate a non-overlapping private address space for the frontend VPC.
# DNS support enables private hostname resolution for EC2 instances.
resource "aws_vpc" "frontend" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "fe-vpc"
  }
}
