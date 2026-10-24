
# Set the AWS Region for the VPC security resources.
# Both VPCs and their peering connection are in Singapore.
variable "aws_region" {
  description = "AWS Region for VPC security resources."
  type        = string
  default     = "ap-southeast-1"
}

# Specify the trusted administrator IPv4 address for SSH and ICMP access.
variable "admin_cidr" {
  description = "Trusted administrator public IPv4 address in CIDR notation."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_cidr)) && tonumber(split("/", var.admin_cidr)[1]) == 32
    error_message = "admin_cidr must be a valid IPv4 /32 CIDR, such as 203.0.113.10/32."
  }
}
