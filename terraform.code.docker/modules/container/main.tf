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
  volumes {
    container_path = var.container_path_in
    volume_name = docker_volume.container_volume[count.index].name
  }
  provisioner "local-exec" {
    command = "echo ${self.name}:${self.network_data[0]["ip_address"]}:${self.ports[0].external} >> ${path.cwd}/../containers.txt"
    when = create
  }
  provisioner "local-exec" {
    command = "rm -f ${path.cwd}/../containers.txt"
    when = destroy
  }
}

resource "docker_volume" "container_volume" {
  count = var.count_in
  name = "${var.name_in}-${random_string.random[count.index].result}-volume"
  lifecycle {
    prevent_destroy = false
  }
  provisioner "local-exec" {
    when = destroy
    command = "mkdir ${path.cwd}/../backup/"
    on_failure = continue
  }
  provisioner "local-exec" {
    when = destroy
    command = "sudo tar -czf ${path.cwd}/../backup/${self.name} /mnt/docker/mnt/docker-desktop-disk/data/docker/volumes/${self.name}/"
    # on_failure = continue
  }
}