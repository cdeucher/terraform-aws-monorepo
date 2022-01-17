
resource "aws_spot_instance_request" "webserver_public" {
  ami           = var.ami
  instance_type = var.instance_type
  spot_price    = var.spot_price
  subnet_id     = var.subnet_public.id

  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group.id]

  tags = {
   Name = "Public_Webserver"
  }

  user_data  = <<-EOF
                  #!/bin/bash
                  sudo apt update -y
                  sudo apt install apache2 -y
                  sudo apt install php libapache2-mod-php php-mcrypt php-mysql -y
                  sudo systemctl start apache2
                  sudo bash -c "echo '<?php phpinfo (); ?>' > /var/www/html/info.php"
                  EOF

  depends_on = [
      var.aws_vpc,
      var.subnet_public,
      var.subnet_private,
      var.security_group
  ]  
}
 
resource "aws_spot_instance_request" "webserver_private" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_private.id
  key_name      = var.key_name
  spot_price    = var.spot_price
  vpc_security_group_ids = [var.security_group.id]

  tags = {
   Name = "Private_Webserver"
  }

  user_data  = <<-EOF
                  #!/bin/bash
                  sudo apt update -y
                  sudo apt install apache2 -y
                  sudo apt install php libapache2-mod-php php-mcrypt php-mysql -y
                  sudo systemctl start apache2
                  sudo bash -c "echo '<?php phpinfo (); ?>' > /var/www/html/info.php"
                  EOF

  depends_on = [
      var.aws_vpc,
      var.subnet_public,
      var.subnet_private,
      var.security_group
  ]   
}