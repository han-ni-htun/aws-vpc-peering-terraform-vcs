# Use a dedicated route table for public subnets to separate
# internet-facing routing from private and peering traffic.
resource "aws_route_table" "fe_public" {
  vpc_id = aws_vpc.frontend.id

  tags = {
    Name = "fe-public-rtb"
  }
}

# Direct internet-bound traffic through the frontend Internet Gateway.
resource "aws_route" "fe_public_internet" {
  route_table_id         = aws_route_table.fe_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.fe_igw.id
}


# Associate all three public subnets with the internet-facing route table
resource "aws_route_table_association" "fe_public_01" {
  subnet_id      = aws_subnet.fe_public_01.id
  route_table_id = aws_route_table.fe_public.id
}

resource "aws_route_table_association" "fe_public_02" {
  subnet_id      = aws_subnet.fe_public_02.id
  route_table_id = aws_route_table.fe_public.id
}

resource "aws_route_table_association" "fe_public_03" {
  subnet_id      = aws_subnet.fe_public_03.id
  route_table_id = aws_route_table.fe_public.id
}


# Isolate private subnet 01 routing from public and peering subnets.
# Outbound internet access is provided through the centralized NAT Gateway.
resource "aws_route_table" "fe_private_01" {
  vpc_id = aws_vpc.frontend.id

  tags = {
    Name = "fe-private-rtb-01"
  }
}

# Route internet-bound traffic from private subnet 01 through NAT.
resource "aws_route" "fe_private_01_nat" {
  route_table_id         = aws_route_table.fe_private_01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.fe_nat.id
}

# Explicitly associate private subnet 01 with its NAT route table.
resource "aws_route_table_association" "fe_private_01" {
  subnet_id      = aws_subnet.fe_private_01.id
  route_table_id = aws_route_table.fe_private_01.id
}


# Dedicate a route table to frontend private subnet 02 for selective
# VPC peering connectivity to backend private subnet 02.
resource "aws_route_table" "fe_private_02" {
  vpc_id = aws_vpc.frontend.id

  tags = {
    Name = "fe-private-rtb-02"
  }
}

# Associate frontend private subnet 02 with its dedicated route table.
resource "aws_route_table_association" "fe_private_02" {
  subnet_id      = aws_subnet.fe_private_02.id
  route_table_id = aws_route_table.fe_private_02.id
}

# Dedicate a route table to frontend private subnet 03 for selective
# VPC peering connectivity to backend private subnet 03.
resource "aws_route_table" "fe_private_03" {
  vpc_id = aws_vpc.frontend.id

  tags = {
    Name = "fe-private-rtb-03"
  }
}

# Associate frontend private subnet 03 with its dedicated route table.
resource "aws_route_table_association" "fe_private_03" {
  subnet_id      = aws_subnet.fe_private_03.id
  route_table_id = aws_route_table.fe_private_03.id
}
