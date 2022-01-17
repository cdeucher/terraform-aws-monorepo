module "vpc" {
  source   = "./modules/vpc"
}

module "sec" {
  source   = "./modules/sec"
  vpc_id   = module.vpc.aws_vpc.id
}

module "ec2" {
  source   = "./modules/ec2"
  
  subnet_public   = module.vpc.subnet_public
  subnet_private  = module.vpc.subnet_private
  security_group  = module.sec.security_group
  aws_vpc         = module.vpc.aws_vpc
}