resource "random_string" "random" {
  count = 2
  length  = 4
  special = false
  upper   = false
}


resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "red_container" {
  count = 2
  name  = join("-", ["red", random_string.random[count.index].result])
  image = docker_image.nodered_image.image_id
  ports {
    internal = 1880
    # external = 1880
    protocol = "tcp"
    ip       = "0.0.0.0"
  }
}



output "container_name" {
    value = docker_container.red_container[*].name
    description = "the name of container"

}

output "container_intrernal_ip" {
    value = [ for i in docker_container.red_container[*] : join (":", [i.network_data[0]["ip_address"], i.ports[0]["external"]] ) ]
    description = "ip and address of container"
}