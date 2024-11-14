# --- networking/output.tf ----

output "vpc_id" {
  value = aws_vpc.rm_vpc.id

}
output "db_security_group" {
  value = [aws_security_group.rm_sg["rds"].id]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rm_rds_subnetgroup.*.name
}