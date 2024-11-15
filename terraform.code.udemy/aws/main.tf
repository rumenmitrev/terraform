data "aws_availability_zones" "available" {

}

module "network" {
  source = "./vpc_nat_ec2"
  aws_region = var.aws_region
}