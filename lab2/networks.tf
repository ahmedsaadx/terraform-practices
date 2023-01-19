resource "aws_vpc" "vpc-1" {
  cidr_block = var.vpc
  tags = {
    "name" = "vpc-1"
  }
}

resource "aws_subnet" "public-subnet" {
  cidr_block              = var.subnet[0]
  vpc_id                  = aws_vpc.vpc-1.id
  map_public_ip_on_launch = true
  tags = {
    "name" = "public-subnet-0"
  }

}
resource "aws_subnet" "private-subnet" {
  cidr_block = var.subnet[1]
  vpc_id     = aws_vpc.vpc-1.id
  tags = {
    "name" = "private-subnet-1"
  }

}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc-1.id
  tags = {
    "name" = "gw-00"
  }
}
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc-1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = {
    "name" = "public_route"
  }
}
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_eip" "ip" {
  vpc = true
  tags = {
    name = "public-ip"
  }

}
resource "aws_nat_gateway" "nat-01" {
  subnet_id     = aws_subnet.public-subnet.id
  allocation_id = aws_eip.ip.id
  depends_on = [
    aws_eip.ip
  ]
  tags = {
    name = "nat-gateway"
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc-1.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-01.id
  }
  tags = {
    name = "private route"
  }

}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private_route.id

}