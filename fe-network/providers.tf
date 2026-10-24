# Deploy frontend networking in Singapore for intra-Region VPC peering.
# Apply consistent ownership tags for resource identification and cleanup.
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "aws-vpc-peering-terraform"
      ManagedBy = "Terraform"
    }
  }
}
