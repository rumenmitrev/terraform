resource "random_string" "random" {
  count   = var.count_in
  length  = 4
  special = false
  upper   = false
}



resource "docker_container" "container" {
  count = var.count_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.internal_in
    external = var.external_in[count.index]
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = module.volume[count.index].volume_output[volumes.key]
    }
  }

  provisioner "local-exec" {
    command = "echo ${self.name}:${self.network_data[0]["ip_address"]}:${self.ports[0].external} >> ${path.cwd}/../containers.txt"
    when    = create
  }
  provisioner "local-exec" {
    command = "rm -f ${path.cwd}/../containers.txt"
    when    = destroy
  }
}

module "volume" {
  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes_in)
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}