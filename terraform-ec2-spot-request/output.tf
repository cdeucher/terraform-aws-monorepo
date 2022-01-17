output "public_ip" {
  value = ["${aws_spot_instance_request.web-server-instance.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_spot_instance_request.web-server-instance.*.public_dns}"]
}