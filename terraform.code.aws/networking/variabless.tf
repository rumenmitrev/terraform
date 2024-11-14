# --- networking/variables.tf ---

variable "vpc_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "public_cidirs" {
  type = list(string)
}

variable "private_cidirs" {
  type = list(string)
}

variable "public_sn_count" {
  type = number
}
variable "private_sn_count" {
  type = number
}

variable "max_subnets" {
  type = number
}

variable "access_ip" {
  type = string
}

variable "security_groups" {}

variable "db_subnet_group" {
  type = bool
}