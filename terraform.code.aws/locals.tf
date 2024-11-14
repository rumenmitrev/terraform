
locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  target_groups = {
    http = {
      name     = "rm-lb-tg-http-${substr(uuid(), 0, 3)}"
      port     = 80
      protocol = "HTTP"
      health_check = {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        interval            = 30
      }
    }
    # https = {
    #   name     = "rm-lb-tg-https-${substr(uuid(), 0, 3)}"
    #   port     = 443
    #   protocol = "HTTPS"
    #   health_check = {
    #     healthy_threshold   = 2
    #     unhealthy_threshold = 2
    #     timeout             = 3
    #     interval            = 30
    #   }
    # }
  }
  security_groups = {
    public = {
      name        = "public_sg"
      description = "SG for public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }

      }
    }
    rds = {
      name        = "rds_sg"
      description = "rds access"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
  }
}