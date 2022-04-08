# devops-app-infra-as-code

Projeto terraform que permite criar e atualizar a infraestrutura de um App com S3 e CloudFront.

## Instalação

Os pacotes abaixo são necessários para utilizar o projeto

```shellscript
# Instalando dependências
$ sudo apt install git git-crypt gpg

# Instalando terraform
$ wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
$ unzip terraform_0.12.2_linux_amd64.zip
$ sudo mkdir /opt/terraform
$ sudo mv terraform /opt/terraform
$ echo "export PATH=$PATH:/opt/terraform" >> ~/.bashrc
$ source ~/.bashrc
```

## Configuração

Configura o git-crypt para usar a chave GPG para encriptar e decriptar
os arquivos de estado do terraform.  Após a chave ser adicionada, o
processo de ecriptação é transparente.

### Configurando git-crypt

```shellscript
$ git-crypt unlock devops-app-infra-as-code.asc
```

### Terraform

```shellscript
$ terraform --version
Terraform v0.14.5
+ provider registry.terraform.io/hashicorp/archive v2.2.0
+ provider registry.terraform.io/hashicorp/aws v3.47.0

Your version of Terraform is out of date! The latest version
is 1.0.1. You can update by downloading from https://www.terraform.io/downloads.html

$ terraform init
$ terraform workspace select <environment>
```

### Executando

Para executar, deve-se usar o `var-file` do ambiente correspondente
que deseja atualizar. Os ambientes que estão disponíveis são:
development, staging e production.

Antes de executar `plan` é necessário desencriptar o state, para isso
não deve haver arquivos com mudanças:

```shellscript
$ git-crypt unlock devops-app-infra-as-code.asc
```

```shellscript
# Executar um plano com as modificações
$ ./run_terraform <environment>
```
