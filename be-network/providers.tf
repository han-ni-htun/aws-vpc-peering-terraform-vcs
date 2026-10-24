# Deploy backend networking in the same AWS Region as the frontend VPC
# to support intra-Region VPC peering.
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "aws-vpc-peering-terraform"
      ManagedBy = "Terraform"
    }
  }
}
