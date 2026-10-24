# Expose the frontend VPC ID for cross-workspace peering configuration.
output "frontend_vpc_id" {
  description = "Frontend VPC identifier used by the backend networking workspace."
  value       = aws_vpc.frontend.id
}

# Export frontend subnet identifiers for downstream compute infrastructure.
output "frontend_subnet_ids" {
  description = "Frontend public and private subnet IDs for EC2 placement."

  value = {
    public_01  = aws_subnet.fe_public_01.id
    public_02  = aws_subnet.fe_public_02.id
    public_03  = aws_subnet.fe_public_03.id
    private_01 = aws_subnet.fe_private_01.id
    private_02 = aws_subnet.fe_private_02.id
    private_03 = aws_subnet.fe_private_03.id
  }
}
