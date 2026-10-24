# Distribute frontend public subnets across three Availability Zones.
# Public routing and internet access will be configured separately.
resource "aws_subnet" "fe_public_01" {
  vpc_id            = aws_vpc.frontend.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "fe-public-subnet-01"
  }
}

resource "aws_subnet" "fe_public_02" {
  vpc_id            = aws_vpc.frontend.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "fe-public-subnet-02"
  }
}

resource "aws_subnet" "fe_public_03" {
  vpc_id            = aws_vpc.frontend.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "fe-public-subnet-03"
  }
}

# Place private subnets in corresponding Availability Zones.
# Route-table associations will enforce the required traffic paths.
resource "aws_subnet" "fe_private_01" {
  vpc_id            = aws_vpc.frontend.id
  cidr_block        = "10.0.253.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "fe-private-subnet-01"
  }
}

resource "aws_subnet" "fe_private_02" {
  vpc_id            = aws_vpc.frontend.id
  cidr_block        = "10.0.254.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "fe-private-subnet-02"
  }
}

resource "aws_subnet" "fe_private_03" {
  vpc_id            = aws_vpc.frontend.id
  cidr_block        = "10.0.255.0/24"
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "fe-private-subnet-03"
  }
}
