# --- networking/output.tf ----

output "vpc_id" {
  value = aws_vpc.rm_vpc.id

}