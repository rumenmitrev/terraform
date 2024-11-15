
data "aws_availability_zones" "available" {

}

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "ec2-key-pair" {
  key_name   = "rm-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "example" {
  count                  = 2
  availability_zone      = data.aws_availability_zones.available.names[1]
  ami                    = data.aws_ami.server_ami.id # use datasource
  vpc_security_group_ids = [aws_security_group.sg-custom_us_east.id]

  #ami           = lookup(var.amis, var.aws_region) # use lookup function to search in map structure
  key_name      = aws_key_pair.ec2-key-pair.key_name
  instance_type = "t2.micro"
  tags = {
    Name = "my-first-ec2-${count.index}"
  }
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.0031
    }
  }

  provisioner "local-exec" {
    command = "echo ${self.id}:${self.public_ip} >> public_ip.txt"
    when    = create
  }

  provisioner "local-exec" {
    command = "rm -f  public_ip.txt"
    when    = destroy
  }

  # provisioner "file" {
  #   source      = "./install_nginx.sh"
  #   destination = "/tmp/install_nginx.sh"
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/install_nginx.sh",
  #     "sudo /tmp/install_nginx.sh"
  #   ]
  # }
  # connection {
  #   host        = self.public_dns
  #   type        = "ssh"
  #   user        = var.ec2_user
  #   private_key = file(var.private_key_path)
  # }
}