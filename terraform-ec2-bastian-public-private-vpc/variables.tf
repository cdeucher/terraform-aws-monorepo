variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}
variable "profile" {
  description = "AWS IAM Profile"
}

/*
# Caminho para a public key SSH
# Edite para a chave pública do seu usuário
variable "key_path" {
  description = "Public key path"
  default = "./security/keys/key.pub"
}*/
