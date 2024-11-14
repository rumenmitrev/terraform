# --- networking/output.tf ----

output "vpc_id" {
  value = aws_vpc.rm_vpc.id

}

# --- database -----
output "db_security_group" {
  value = [aws_security_group.rm_sg["rds"].id]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rm_rds_subnetgroup.*.name
}

# --- alb -----
output "public_sg" {
  value = [aws_security_group.rm_sg["public"].id]
}

output "public_subnets" {
  value = aws_subnet.rm_public_subnet.*.id
}