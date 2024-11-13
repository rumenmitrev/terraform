# --- networking/variables.tf ---

variable "vpc_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "public_cidirs" {
  type = list(string)
}