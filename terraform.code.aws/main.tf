# --- root/main.tf ---

module "networking" {
  source        = "./networking"
  vpc_cidr      = "10.100.0.0/16"
  public_cidirs = ["10.100.192.0/19", "10.100.224.0/19"]

}