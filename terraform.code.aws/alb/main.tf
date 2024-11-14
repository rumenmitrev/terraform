# --- alb/main.tf ----

resource "aws_lb" "rm_lb" {
  name            = "rm-loadbalancer"
  subnets         = var.public_subnets
  security_groups = var.public_sg
  idle_timeout    = 400
}

resource "aws_lb_target_group" "rm-aws_lb_target_group" {
  for_each = var.target_groups
  name     = each.value.name
  port     = each.value.port
  protocol = each.value.protocol
  vpc_id   = var.vpc_id
  dynamic "health_check" {
    for_each = [each.value.health_check]
    content {
      healthy_threshold   = health_check.value.healthy_threshold
      unhealthy_threshold = health_check.value.unhealthy_threshold
      timeout             = health_check.value.timeout
      interval            = health_check.value.interval
    }
  }
}