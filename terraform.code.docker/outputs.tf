
output "container_name" {
  value       = module.container[*].container_name
  description = "the name of container"

}

output "container_intrernal_ip" {
  value       = flatten(module.container[*].container_intrernal_ip)
  description = "ip and address of container"
}