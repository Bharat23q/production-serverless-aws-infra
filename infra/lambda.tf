resource "aws_lambda_function" "api" {
  function_name = "${var.project_name}-api"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "app.handler.lambda_handler"
  runtime       = "python3.11"

  filename         = "../lambda_package.zip"
  source_code_hash = filebase64sha256("../lambda_package.zip")

  timeout     = 10
  memory_size = 256

  environment {
    variables = {
      DB_HOST     = aws_db_instance.postgres.address
      DB_PORT     = "5432"
      DB_NAME     = var.db_name
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
    }
  }

  vpc_config {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = [for s in aws_subnet.private : s.id]
  }

  tags = {
    Name = "${var.project_name}-lambda-api"
  }
}
