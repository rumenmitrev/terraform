


output "container_name" {
  value       = docker_container.red_container[*].name
  description = "the name of container"

}

output "container_intrernal_ip" {
  value       = [for i in docker_container.red_container[*] : join(":", [i.network_data[0]["ip_address"], i.ports[0]["external"]])]
  description = "ip and address of container"
}