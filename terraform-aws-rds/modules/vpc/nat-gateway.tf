
resource "aws_nat_gateway" "nat_gateway" {
    # Allocating the Elastic IP to the NAT Gateway!
    allocation_id = aws_eip.nat_gateway_eip.id
    
    # Associating it in the Public Subnet!
    subnet_id = aws_subnet.subnet_public.id

    depends_on = [
      aws_eip.nat_gateway_eip,
      aws_subnet.subnet_public
    ]
    tags = {
      Name = "Nat_Gateway"
    }
}

resource "aws_route_table" "r_private" {
    depends_on = [
      aws_nat_gateway.nat_gateway
    ]

    vpc_id = aws_vpc.main.id

    route {
      #  point to NAT gateway
      cidr_block = "0.0.0.0/0" 
      nat_gateway_id = aws_nat_gateway.nat_gateway.id
    }

    tags = {
      Name = "Route Table for NAT Gateway"
    }
}

resource "aws_route_table_association" "a_private" {
    #  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
    subnet_id      = aws_subnet.subnet_private.id

    #  Route Table ID
    route_table_id = aws_route_table.r_private.id

    depends_on = [
      aws_route_table.r_private
    ]    
}