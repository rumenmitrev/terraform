resource "docker_volume" "container_volume" {
  count = var.volume_count
  name  = "${var.volume_name}-${count.index}"
  lifecycle {
    prevent_destroy = false
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir ${path.cwd}/../backup/"
    on_failure = continue
  }
  provisioner "local-exec" {
    when    = destroy
    command = "sudo tar -czf ${path.cwd}/../backup/${self.name} /mnt/docker/mnt/docker-desktop-disk/data/docker/volumes/${self.name}/"
    # on_failure = continue
  }
}