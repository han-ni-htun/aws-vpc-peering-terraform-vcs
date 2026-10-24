# Publish the backend VPC identifier for cross-workspace
# networking dependencies and future peering configuration.
output "backend_vpc_id" {
  description = "Backend VPC identifier used for cross-workspace networking."
  value       = aws_vpc.backend.id
}


# Export the VPC peering connection ID for the frontend networking workspace.
# Frontend route tables will reference this ID without hardcoding it.
output "vpc_peering_connection_id" {
  description = "ID of the VPC peering connection between backend and frontend."
  value       = aws_vpc_peering_connection.be_to_fe.id
}

# Export backend subnet identifiers for downstream compute infrastructure.
output "backend_subnet_ids" {
  description = "Backend public and private subnet IDs for EC2 placement."

  value = {
    public_01  = aws_subnet.be_public_01.id
    public_02  = aws_subnet.be_public_02.id
    public_03  = aws_subnet.be_public_03.id
    private_01 = aws_subnet.be_private_01.id
    private_02 = aws_subnet.be_private_02.id
    private_03 = aws_subnet.be_private_03.id
  }
}
