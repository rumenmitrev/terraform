variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "my_ip" {
  type = string
}

variable "amis" {
  type = map(any)
  default = {
    us-east-1 = "ami-0664c8f94c2a2261b"
    us-east-2 = "ami-0664c8f94c2a2261b"
  }
}

variable "private_key_path" {
  type    = string
  default = "/home/rmitrev/.ssh/id_rsa"
}

variable "public_key_path" {
  type    = string
  default = "/home/rmitrev/.ssh/id_rsa.pub"
}

variable "ec2_user" {
  type    = string
  default = "ubuntu"
}