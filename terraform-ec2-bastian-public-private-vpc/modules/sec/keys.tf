
/*
resource "tls_private_key" "webserver_key" {
    algorithm   =  "RSA"
    rsa_bits    =  4096
}
resource "local_file" "private_key" {
    content         =  tls_private_key.webserver_key.private_key_pem
    filename        =  "private_key.pem"
    file_permission =  0400
}
resource "aws_key_pair" "webserver_key" {
    key_name   = "private_key"
    public_key = tls_private_key.webserver_key.public_key_openssh
}
*/