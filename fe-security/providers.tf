
# Manage security groups in the same Singapore Region as both VPCs.
# Apply consistent project tags to supported AWS resources.
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "aws-vpc-peering-terraform"
      ManagedBy = "Terraform"
    }
  }
}
