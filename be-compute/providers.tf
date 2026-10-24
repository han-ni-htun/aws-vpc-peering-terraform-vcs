# Configure the AWS provider for infrastructure in the Singapore Region.
provider "aws" {
  region = var.aws_region

  # Apply consistent ownership tags to supported AWS resources.
  default_tags {
    tags = {
      Project   = "aws-vpc-peering-terraform"
      ManagedBy = "Terraform"
    }
  }
}
