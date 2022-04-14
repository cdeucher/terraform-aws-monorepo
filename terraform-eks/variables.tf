variable "aws_region" {
  type        = string
  description = "AWS region on which to deploy our EKS cluster."
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI profile to use."
  default     = "default"
}

variable "eks_node_ami_id" {
  type        = string
  description = "ID of the AMI used for our EKS cluster nodes."
  default     = "ami-0c6f20e00e2f5869a"

  validation {
    condition     = length(var.eks_node_ami_id) > 4 && substr(var.eks_node_ami_id, 0, 4) == "ami-"
    error_message = "The node_ami_id value must be a valid AMI id, starting with 'ami-'."
  }
}

variable "eks_node_ami_is_eks_optimized" {
  type        = bool
  description = "Whether the AMI being used is optimized for EKS."
  default     = true
}

variable "eks_node_disk_size" {
  type        = number
  description = "Disk size for each EKS node in GB."
  default     = 128
}

variable "eks_node_disk_type" {
  type        = string
  description = "Disk type for each EKS node."
  default     = "gp2"
}

variable "eks_ng_nodes_instance_type" {
  type        = string
  description = "Instance type used by the 'nodes' node group."
  default     = "t2.medium"
}

variable "eks_ng_nodes_desired_capacity" {
  type        = number
  description = "Desired capacity for the 'nodes' node group."
  default     = 1
}

variable "eks_ng_nodes_max_capacity" {
  type        = number
  description = "Maximum capacity for the 'nodes' node group."
  default     = 2
}

variable "eks_ng_nodes_min_capacity" {
  type        = number
  description = "Minimum capacity for the 'nodes' node group."
  default     = 1
}
