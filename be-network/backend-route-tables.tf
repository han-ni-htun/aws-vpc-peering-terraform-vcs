# Use a dedicated route table for backend public subnets to separate
# internet-facing routing from private and peering traffic.
resource "aws_route_table" "be_public" {
  vpc_id = aws_vpc.backend.id

  tags = {
    Name = "be-public-rtb"
  }
}

# Direct internet-bound traffic through the backend Internet Gateway.
resource "aws_route" "be_public_internet" {
  route_table_id         = aws_route_table.be_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.be_igw.id
}

# Associate all three public subnets with the internet-facing
# route table while keeping EC2 placement limited to subnet 01.
resource "aws_route_table_association" "be_public_01" {
  subnet_id      = aws_subnet.be_public_01.id
  route_table_id = aws_route_table.be_public.id
}

resource "aws_route_table_association" "be_public_02" {
  subnet_id      = aws_subnet.be_public_02.id
  route_table_id = aws_route_table.be_public.id
}

resource "aws_route_table_association" "be_public_03" {
  subnet_id      = aws_subnet.be_public_03.id
  route_table_id = aws_route_table.be_public.id
}


# Isolate backend private subnet 01 routing from public and peering subnets.
# Outbound internet access is provided through the backend NAT Gateway.
resource "aws_route_table" "be_private_01" {
  vpc_id = aws_vpc.backend.id

  tags = {
    Name = "be-private-rtb-01"
  }
}

# Route internet-bound traffic from backend private subnet 01 through NAT.
resource "aws_route" "be_private_01_nat" {
  route_table_id         = aws_route_table.be_private_01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.be_nat.id
}

# Explicitly associate backend private subnet 01 with its NAT route table.
resource "aws_route_table_association" "be_private_01" {
  subnet_id      = aws_subnet.be_private_01.id
  route_table_id = aws_route_table.be_private_01.id
}


# Dedicate a route table to backend private subnet 02 for selective
# VPC peering connectivity to frontend private subnet 02.
resource "aws_route_table" "be_private_02" {
  vpc_id = aws_vpc.backend.id

  tags = {
    Name = "be-private-rtb-02"
  }
}

# Associate backend private subnet 02 with its dedicated route table.
resource "aws_route_table_association" "be_private_02" {
  subnet_id      = aws_subnet.be_private_02.id
  route_table_id = aws_route_table.be_private_02.id
}

# Dedicate a route table to backend private subnet 03 for selective
# VPC peering connectivity to frontend private subnet 03.
resource "aws_route_table" "be_private_03" {
  vpc_id = aws_vpc.backend.id

  tags = {
    Name = "be-private-rtb-03"
  }
}

# Associate backend private subnet 03 with its dedicated route table.
resource "aws_route_table_association" "be_private_03" {
  subnet_id      = aws_subnet.be_private_03.id
  route_table_id = aws_route_table.be_private_03.id
}
