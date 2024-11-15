# output "aws_a" {
#   value = [for az in data.aws_availability_zones.available.names : az]
# }

# output "ip_ranges_us_east" {
#   value = data.aws_ip_ranges.us_east_1_ip_range
# }

output "public_ip" {
  value = aws_instance.example[*].public_ip
}