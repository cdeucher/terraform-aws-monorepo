module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version
  subnet_ids      = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_id               = var.eks_node_ami_id
    ami_is_eks_optimized = var.eks_node_ami_is_eks_optimized

    enable_monitoring = false

    create_launch_template = true
    ebs_optimized          = false
    public_ip              = false
    subnets                = module.vpc.private_subnets

    disk_size = var.eks_node_disk_size
    disk_type = var.eks_node_disk_type

    additional_tags = {
      SubService    = local.cluster_name
      DevOpsService = "true"
      Service       = local.cluster_name
    }
  }

  eks_managed_node_groups = {
    one = {
      name = "nodes"

      instance_types = [var.eks_ng_nodes_instance_type]

      capacity_type    = "SPOT"
      desired_capacity = var.eks_ng_nodes_desired_capacity
      max_capacity     = var.eks_ng_nodes_max_capacity
      min_capacity     = var.eks_ng_nodes_min_capacity
    }
  }


  tags = local.eks_common_tags
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
