# Attach an Internet Gateway to the backend VPC to support
# public subnet routing and outbound traffic from the NAT Gateway.
resource "aws_internet_gateway" "be_igw" {
  vpc_id = aws_vpc.backend.id

  tags = {
    Name = "be-igw"
  }
}

# Reserve a public IPv4 address for the backend NAT Gateway.
# The stable address supports outbound internet connectivity.
resource "aws_eip" "be_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "be-nat-eip"
  }
}

# Place the public NAT Gateway in backend public subnet 01.
# Its internet-bound traffic depends on the VPC Internet Gateway.
resource "aws_nat_gateway" "be_nat" {
  allocation_id = aws_eip.be_nat_eip.id
  subnet_id     = aws_subnet.be_public_01.id

  depends_on = [aws_internet_gateway.be_igw]

  tags = {
    Name = "be-nat-gw"
  }
}
