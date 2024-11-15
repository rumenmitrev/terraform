output "aws_a" {
  value = [for az in data.aws_availability_zones.available.names : az]
}