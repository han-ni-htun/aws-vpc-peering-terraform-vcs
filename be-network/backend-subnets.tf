# Distribute backend public subnets across three Availability Zones.
# Internet-facing routing will be configured separately.
resource "aws_subnet" "be_public_01" {
  vpc_id            = aws_vpc.backend.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "be-public-subnet-01"
  }
}

resource "aws_subnet" "be_public_02" {
  vpc_id            = aws_vpc.backend.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "be-public-subnet-02"
  }
}

resource "aws_subnet" "be_public_03" {
  vpc_id            = aws_vpc.backend.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "be-public-subnet-03"
  }
}

# Place backend private subnets in corresponding Availability Zones.
# Dedicated route tables will enforce NAT and selective peering paths.
resource "aws_subnet" "be_private_01" {
  vpc_id            = aws_vpc.backend.id
  cidr_block        = "192.168.253.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "be-private-subnet-01"
  }
}

resource "aws_subnet" "be_private_02" {
  vpc_id            = aws_vpc.backend.id
  cidr_block        = "192.168.254.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "be-private-subnet-02"
  }
}

resource "aws_subnet" "be_private_03" {
  vpc_id            = aws_vpc.backend.id
  cidr_block        = "192.168.255.0/24"
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "be-private-subnet-03"
  }
}
