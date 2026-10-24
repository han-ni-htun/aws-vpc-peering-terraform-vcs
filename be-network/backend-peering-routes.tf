
# Route traffic from Backend Private Subnet 02 to Frontend Private Subnet 02.
# Only the matching frontend subnet CIDR is routed through VPC peering.
resource "aws_route" "be_private_02_peering" {
  route_table_id            = aws_route_table.be_private_02.id
  destination_cidr_block    = "10.0.254.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.be_to_fe.id
}

# Route traffic from Backend Private Subnet 03 to Frontend Private Subnet 03.
# Keep this route separate from Private Subnet 02 for selective connectivity.
resource "aws_route" "be_private_03_peering" {
  route_table_id            = aws_route_table.be_private_03.id
  destination_cidr_block    = "10.0.255.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.be_to_fe.id
}
