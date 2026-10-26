# Route Frontend Private Subnet 02 traffic to Backend Private Subnet 02.
# Use the peering connection ID exported by the backend workspace.
resource "aws_route" "fe_private_02_peering" {
  route_table_id            = aws_route_table.fe_private_02.id
  destination_cidr_block    = "192.168.254.0/24"
  vpc_peering_connection_id = data.terraform_remote_state.backend.outputs.vpc_peering_connection_id
}

# Route Frontend Private Subnet 03 traffic to Backend Private Subnet 03.
# Keep this route separate for selective inter-VPC connectivity.
resource "aws_route" "fe_private_03_peering" {
  route_table_id            = aws_route_table.fe_private_03.id
  destination_cidr_block    = "192.168.255.0/24"
  vpc_peering_connection_id = data.terraform_remote_state.backend.outputs.vpc_peering_connection_id
}
