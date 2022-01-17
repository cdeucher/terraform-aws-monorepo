output "bastian_public_ip" {
    value = aws_spot_instance_request.webserver_public.public_ip
}
output "instance_private_ip" {
    value = aws_spot_instance_request.webserver_private.private_ip
}

