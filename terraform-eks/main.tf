terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~ 3.63.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~ 2.6.1"
    }
  }

  required_version = ">= 0.14.0"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
