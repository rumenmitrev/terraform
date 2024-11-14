# --- alb/main.tf ----

resource "aws_lb" "rm_lb" {
  name            = "rm-loadbalancer"
  subnets         = var.public_subnets
  security_groups = var.public_sg
  idle_timeout    = 400
}