# Configure the AWS Region used by the EC2 infrastructure.
variable "aws_region" {
  description = "AWS Region for EC2 resources."
  type        = string
  default     = "ap-southeast-1"
}

# Supply the administrator SSH public key without storing it in Git.
variable "ssh_public_key" {
  description = "OpenSSH public key for EC2 administrative access."
  type        = string
  sensitive   = false
}

# Select a small EC2 instance type for connectivity testing.
variable "instance_type" {
  description = "EC2 instance type used for the VPC peering demonstration."
  type        = string
  default     = "t3.large"
}
