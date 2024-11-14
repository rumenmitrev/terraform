# --- alb/main.tf ----

resource "aws_lb" "rm_lb" {
  name            = "rm-loadbalancer"
  subnets         = var.public_subnets
  security_groups = var.public_sg
  idle_timeout    = 400
}

resource "aws_lb_target_group" "rm-aws_lb_target_group" {
  name = "rm-lb-tg-${substr(uuid(), 0, 3)}"
  port = var.tg_port
  protocol = var.tg_protocol
  vpc_id = var.vpc_id
  health_check {
    healthy_threshold = var.lb_healthy_tresh
    unhealthy_threshold = var.lb_unhealthy_tresh
    timeout = var.lb_timeout
    interval = var.lb_interval
  }
}