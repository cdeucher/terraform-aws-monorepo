#  Public IP - NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
    vpc = true
}