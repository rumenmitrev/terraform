# --- root/main.tf ---



module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  access_ip        = var.access_ip
  security_groups  = local.security_groups
  public_sn_count  = 2
  private_sn_count = 3
  max_subnets      = 20
  public_cidirs    = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidirs   = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  db_subnet_group  = true
}

# module "database" {
#   source                 = "./database"
#   db_storage             = var.db_storage
#   db_engine_version      = var.db_engine_version
#   instance_class         = var.instance_class
#   dbname                 = var.dbname
#   dbuser                 = var.dbuser
#   dbpass                 = var.dbpass
#   skip_final_snapshot    = var.skip_final_snapshot
#   db_subnet_group_name   = module.networking.db_subnet_group_name[0]
#   vpc_security_group_ids = module.networking.db_security_group
#   db_identifier          = var.db_identifier
# }


module "alb" {
  source         = "./alb"
  public_sg      = module.networking.public_sg
  public_subnets = module.networking.public_subnets
  vpc_id = module.networking.vpc_id
  tg_protocol = "HTTP"
  tg_port = "80"
  lb_healthy_tresh = 2
  lb_unhealthy_tresh = 2
  lb_interval = 30
  lb_timeout = 3
}