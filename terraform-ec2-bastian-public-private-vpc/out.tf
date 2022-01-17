output "bastian_public_ip" {
    value = module.ec2.bastian_public_ip
}
output "instance_private_ip" {
    value = module.ec2.instance_private_ip
}