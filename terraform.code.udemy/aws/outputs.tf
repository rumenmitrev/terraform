# output "aws_a" {
#   value = [for az in data.aws_availability_zones.available.names : az]
# }

output "public_ip" {
  value = module.network.public_ip
}