

# resource "docker_image" "nodered_image" {
#   name = var.image[terraform.workspace]
# }

locals {
  deployment = {
    red = {
      container_count = length(var.ext_port["red"][terraform.workspace])
      image           = var.image["red_image"][terraform.workspace]
      ext             = var.ext_port["red"][terraform.workspace]
      int             = 1880
      container_path  = "/data"
    }
    influx = {
      container_count = length(var.ext_port["influx"][terraform.workspace])
      image           = var.image["influx_image"][terraform.workspace]
      ext             = var.ext_port["influx"][terraform.workspace]
      int             = 8086
      container_path  = "/var/lib/influxdb"
    }
  }
}

module "image" {
  source   = "./modules/image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  # depends_on        = [terraform_data.dockervol]
  source   = "./modules/container"
  for_each = local.deployment

  count_in          = each.value.container_count
  name_in           = each.key
  image_in          = module.image[each.key].image_id
  internal_in       = each.value.int
  external_in       = each.value.ext
  container_path_in = each.value.container_path
}

# resource "terraform_data" "dockervol" {
#   provisioner "local-exec" {
#     command = "mkdir nodered/ || true &&  chown 1000:1000 nodered/"
#   }
# }
