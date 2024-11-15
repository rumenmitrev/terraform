data "aws_ip_ranges" "us_east_1_ip_range" {
  regions  = ["us-east-1", "us-east-2"]
  services = ["ec2"]
}

resource "aws_security_group" "sg-custom_us_east" {
  name = "sec-group-custom_us_east"
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = concat(slice(data.aws_ip_ranges.us_east_1_ip_range.cidr_blocks, 0, 5), [var.my_ip])
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }
  tags = {
    CreateDate = data.aws_ip_ranges.us_east_1_ip_range.create_date
    SyncToken  = data.aws_ip_ranges.us_east_1_ip_range.sync_token
  }
} 