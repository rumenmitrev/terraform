# --- root/variables.tf ---

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cdir" {
  type    = string
  default = "10.123.0.0/16"
}