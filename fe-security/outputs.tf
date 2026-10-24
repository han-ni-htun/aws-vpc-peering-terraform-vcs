
# Export frontend Security Group IDs for cross-workspace rule references.
# These outputs keep AWS-generated identifiers out of Terraform configuration.
output "frontend_security_group_ids" {
  description = "Security Group IDs for frontend public and private instances."

  value = {
    public_01  = aws_security_group.fe_public_01.id
    private_01 = aws_security_group.fe_private_01.id
    private_02 = aws_security_group.fe_private_02.id
    private_03 = aws_security_group.fe_private_03.id
  }
}
