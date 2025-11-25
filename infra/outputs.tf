output "api_gateway_invoke_url" {
  description = "Base URL for the API Gateway stage"
  value       = aws_api_gateway_stage.prod.invoke_url
}

output "rds_endpoint" {
  description = "RDS endpoint address"
  value       = aws_db_instance.postgres.address
}

output "rds_database_name" {
  description = "RDS database name"
  value       = aws_db_instance.postgres.db_name
}
