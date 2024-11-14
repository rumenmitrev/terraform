# --- database/main.tf ----

resource "aws_db_instance" "rm_db" {
  allocated_storage      = var.db_storage
  engine                 = "mysql"
  engine_version         = var.db_engine_version
  instance_class         = var.instance_class
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  identifier             = var.db_identifier
  skip_final_snapshot    = var.skip_final_snapshot
  tags = {
    Name = "rm-db"
  }

}