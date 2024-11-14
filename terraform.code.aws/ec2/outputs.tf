output "aim_id" {
  value = {
    for ami in [data.aws_ami.server_ami] : ami.id => {
      architecture = ami.architecture
      arn          = ami.arn
    }
  }
}