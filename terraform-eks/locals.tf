locals {
  cluster_name    = "devops-eks"
  cluster_version = "1.21"

  eks_common_tags = {
    Service    = "Devops-eks"
    SubService = "Devops-eks"
  }
}
