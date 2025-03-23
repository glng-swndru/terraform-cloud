resource "aws_db_instance" "default" {
  allocated_storage    = var.db_storage
  db_name              = var.db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
} 