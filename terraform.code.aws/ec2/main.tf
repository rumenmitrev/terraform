# --- ec2/main.tf ----

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "random_id" "rm_node_id" {
  byte_length = 2
  count       = var.instance_count
  keepers = {
    key_name = var.key_name
  }
}

resource "aws_key_pair" "spot-key" {
  key_name   = var.key_name
  public_key = file(var.key_path)
}

resource "aws_instance" "rm_node" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id
  tags = {
    Name = "rm-node-${random_id.rm_node_id[count.index].dec}"
  }
  vpc_security_group_ids = var.public_sg
  subnet_id              = var.public_subnets[count.index]
  user_data = templatefile(var.userdata_path,
    {
      nodename    = "rm-node-${random_id.rm_node_id[count.index].dec}"
      db_endpoint = var.db_endpoint
      dbuser      = var.dbuser
      dbpass      = var.dbpass
      dbname      = var.dbname
    }
  )
  key_name = aws_key_pair.spot-key.id
  root_block_device {
    volume_size = var.volume_size
  }
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.0031
    }
  }
}