resource "aws_spot_instance_request" "web-server-instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  spot_price    = var.spot_price
  spot_type     = var.spot_type
  availability_zone               = var.availability_zone
  vpc_security_group_ids          = [aws_security_group.allow_spot.id]
  key_name                        = var.key_name
  associate_public_ip_address     = true
  wait_for_fulfillment            = true

  root_block_device {
    volume_size           = var.disk_size
    delete_on_termination = true
  }  
  timeouts {
    create = "20m"
  }
  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }
  tags = {
      Name = "Spot"
  }

  provisioner "local-exec" {
    command = <<-EOF
                # apt update -y && \
                # apt install -y docker && \
                # apt install -y docker.io && \
                # apt install -y docker-compose && \
                # sysctl -w vm.max_map_count=262144
                EOF
  }  
}
