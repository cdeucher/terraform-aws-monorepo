module "vpc" {
  source = "./modules/vpc"  
}

module "sec" {
  source = "./modules/sec" 
  vpc_id = module.vpc.aws_vpc.id

  depends_on = [
    module.vpc.aws_vpc,
    module.vpc.subnet_private
  ]
}

module "rds" {
  source          = "./modules/rds"
  db_password     = var.db_password
  vpc             = module.vpc.aws_vpc
  subnet          = [module.vpc.subnet_private.id, module.vpc.subnet_public.id]
  security_group  = module.sec.security_group

  #count = 0

  depends_on = [
    module.vpc.aws_vpc,
    module.vpc.subnet_private,
    module.sec.security_group
  ]
}

module "standalone" {
  source               = "./modules/standalone" 
  db_password          = var.db_password
  vpc_id               = ""
  security_group_id    = ""

  count = 0
}
