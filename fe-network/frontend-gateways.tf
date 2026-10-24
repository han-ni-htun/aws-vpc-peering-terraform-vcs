# Attach an Internet Gateway to the frontend VPC to support
# public subnet routing and outbound traffic from the NAT Gateway.
resource "aws_internet_gateway" "fe_igw" {
  vpc_id = aws_vpc.frontend.id

  tags = {
    Name = "fe-igw"
  }
}


# Reserve a public IPv4 address for the frontend NAT Gateway.
# The stable address supports outbound internet connectivity.
resource "aws_eip" "fe_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "fe-nat-eip"
  }
}

# Place the public NAT Gateway in frontend public subnet 01.
# Its internet-bound traffic depends on the VPC Internet Gateway.
resource "aws_nat_gateway" "fe_nat" {
  allocation_id = aws_eip.fe_nat_eip.id
  subnet_id     = aws_subnet.fe_public_01.id

  depends_on = [aws_internet_gateway.fe_igw]

  tags = {
    Name = "fe-nat-gw"
  }
}
