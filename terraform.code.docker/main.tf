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

module "container" {
  depends_on        = [terraform_data.dockervol]
  source            = "./modules/container"
  count             = local.counter_lel
  name_in           = join("-", ["red", terraform.workspace, random_string.random[count.index].result])
  image_in          = module.image.image_id
  internal_in       = var.int_port
  external_in       = var.ext_port[terraform.workspace][count.index]
  container_path_in = "/data"
  host_path_in      = "${path.cwd}/nodered"

}

resource "terraform_data" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir nodered/ || true &&  chown 1000:1000 nodered/"
  }

}
