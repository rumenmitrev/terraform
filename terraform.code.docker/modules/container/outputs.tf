

output "container_acces" {
  value       = {for i in docker_container.container[*]: i.name => join(":", [i.network_data[0]["ip_address"], i.ports[0]["external"]])}
  description = "name ip port of the app"
}