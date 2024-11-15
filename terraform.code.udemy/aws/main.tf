data "aws_availability_zones" "available" {

}

module "network" {
  source           = "./vpc_nat_ec2"
  aws_region       = var.aws_region
  my_ip            = var.my_ip
  private_key_path = var.private_key_path
  ec2_user         = var.ec2_user
  public_key_path  = var.public_key_path
}