# --- root/variables.tf ---

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "access_ip" {
  type = string
}

variable "db_storage" {}
variable "instance_class" {}
variable "dbname" {}
variable "dbuser" {
  sensitive = true
}
variable "dbpass" {
  sensitive = true
}
# variable "vpc_security_group_ids" {}
# variable "db_subnet_group_name" {}
variable "db_engine_version" {}
variable "db_identifier" {}
variable "skip_final_snapshot" {}