resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [for s in aws_subnet.private : s.id]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "${var.project_name}-postgres"
  allocated_storage       = var.db_allocated_storage
  engine                  = "postgres"
  engine_version          = "16.3"
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  deletion_protection     = false
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.rds.arn
  publicly_accessible     = false
  backup_retention_period = 7

  tags = {
    Name = "${var.project_name}-postgres"
  }
}
