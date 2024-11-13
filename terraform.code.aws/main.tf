# --- root/main.tf ---

module "networking" {
  source           = "./networking"
  vpc_cidr         = var.vpc_cdir
  public_sn_count  = 2
  private_sn_count = 5
  max_subnets      = 20
  public_cidirs    = [for i in range(2, 255, 2) : cidrsubnet("${var.vpc_cdir}", 8, i)]
  private_cidirs   = [for i in range(1, 255, 2) : cidrsubnet("${var.vpc_cdir}", 8, i)]

}