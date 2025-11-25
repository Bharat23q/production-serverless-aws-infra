resource "aws_kms_key" "rds" {
  description             = "KMS CMK for RDS encryption for ${var.project_name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.project_name}-rds-kms-key"
  }
}

resource "aws_kms_alias" "rds_alias" {
  name          = "alias/${var.project_name}-rds-kms"
  target_key_id = aws_kms_key.rds.key_id
}
