resource "aws_subnet" "subnet_private" { 
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    depends_on = [
      aws_vpc.main,
      aws_vpc.main
    ]  
    tags = {
      Name = "Private Subnet"
    }
}