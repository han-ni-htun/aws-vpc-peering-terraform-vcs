
# Establish private connectivity between the backend and frontend VPCs.
# The backend workspace owns this peering connection.
resource "aws_vpc_peering_connection" "be_to_fe" {
  # Use the backend VPC managed by this Terraform workspace.
  vpc_id = aws_vpc.backend.id

  # Read the current frontend VPC ID from its HCP Terraform state.
  # This avoids hardcoding AWS-generated resource identifiers.
  peer_vpc_id = data.terraform_remote_state.frontend.outputs.frontend_vpc_id

  # Both VPCs belong to the same AWS account and Region.
  # Automatically accept the peering request during creation.
  auto_accept = true

  # Identify the peering connection in the AWS Console.
  tags = {
    Name = "be-to-fe-vpc-peering"
  }
}
