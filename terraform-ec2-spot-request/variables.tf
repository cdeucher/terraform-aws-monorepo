variable vpc_id {
  type        = string
  default     = "vpc-380ba045"
}

variable profile {
  type        = string
  default     = "terraform_iam_user"
  description = "AWS Profile"
}

variable key_name {
  type        = string
  default     = "MyKeyPair.pem.pub"
  description = "Key Pair Name"
}

variable image_id {
  type        = string
  default     = "ami-02fe94dee086c0c37"
}

variable spot_price {
  type        = string
  default     = "0.03"
}

variable instance_type {
  type        = string
  default     = "t2.medium"
}

variable spot_type {
  type        = string
  default     = "one-time"
}

variable region {
  type        = string
  default     = "us-east-1"
}

variable availability_zone {
  type        = string
  default     = "us-east-1a"
}

variable disk_size {
  type    = number
  default = 15
}



