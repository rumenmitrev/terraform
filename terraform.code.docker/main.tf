resource "random_string" "random" {
  count   = local.counter_lel
  length  = 4
  special = false
  upper   = false
}


# resource "docker_image" "nodered_image" {
#   name = var.image[terraform.workspace]
# }

module "image" {
  source   = "./modules/image"
  image_in = var.image[terraform.workspace]
}

resource "docker_container" "red_container" {
  count = local.counter_lel
  name  = join("-", ["red", terraform.workspace, random_string.random[count.index].result])
  image = module.image.image_id
  ports {
    internal = var.int_port
    external = var.ext_port[terraform.workspace][count.index]
    protocol = "tcp"
    ip       = "0.0.0.0"
  }
  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/nodered"
  }
}

resource "terraform_data" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir nodered/ || true &&  chown 1000:1000 nodered/"
  }

}
