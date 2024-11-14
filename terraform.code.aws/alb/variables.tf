# --- alb/variables.tf ---

variable "public_sg" {}
variable "public_subnets" {}
variable "vpc_id" {}
variable "tg_port" {}
variable "tg_protocol" {}
variable "lb_healthy_tresh" {}
variable "lb_unhealthy_tresh" {}
variable "lb_interval" {}
variable "lb_timeout" {}