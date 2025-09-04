
resource "aws_vpc" "webAppSuite" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "webAppSuite-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.webAppSuite.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "webAppSuite-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.webAppSuite.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "webAppSuite-public-b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.webAppSuite.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "webAppSuite-private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.webAppSuite.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "webAppSuite-private-b"
  }
}

resource "aws_internet_gateway" "webAppSuite" {
  vpc_id = aws_vpc.webAppSuite.id
  tags = {
    Name = "webAppSuite-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.webAppSuite.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.webAppSuite.id
  }
  tags = {
    Name = "webAppSuite-public-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "webAppSuite" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id
  tags = {
    Name = "webAppSuite-nat"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.webAppSuite.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.webAppSuite.id
  }
  tags = {
    Name = "webAppSuite-private-rt"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
