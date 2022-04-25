resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  depends_on = [
    aws_vpc.main,
    aws_subnet.subnet_public,
    aws_subnet.subnet_private
  ]  
  tags = {
    Name = "IG-Public/Private-VPC"
  }  
}

resource "aws_route_table" "r_public" {
  vpc_id = aws_vpc.main.id
  route {
    #  point to internet gateway
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    ipv6_cidr_block   = "::/0"
    gateway_id        = aws_internet_gateway.gw.id
  }

  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.gw
  ]  
}

resource "aws_route_table_association" "a_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.r_public.id
}