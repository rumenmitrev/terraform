
output "app_acces" {
  value       = [for x in module.container[*] : x]
  description = "name IP port of the app"
}