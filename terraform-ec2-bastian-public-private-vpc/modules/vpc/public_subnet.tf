resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  
  #
  # Ira gerar um IP Publico para cada instancia dentro da sub publica
  # caso contrario é preciso criar (aws_eip e network_interface dentro da aws_instance) para cada instancia
  #
  map_public_ip_on_launch = true

  depends_on = [
    aws_vpc.main
  ]   
  tags = {
    Name = "Public Subnet"
  }  
}