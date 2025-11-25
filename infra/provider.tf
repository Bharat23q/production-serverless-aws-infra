terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: configure a remote backend (uncomment and adjust if you want S3 backend)
  # backend "s3" {
  #   bucket = "FIXME_S3_BACKEND_BUCKET"   # <-- REPLACE with your S3 bucket
  #   key    = "FIXME_S3_BACKEND_KEY"      # <-- REPLACE with your tfstate object key
  #   region = "FIXME_AWS_REGION"          # <-- REPLACE with your region
  # }
}

provider "aws" {
  region = var.aws_region
}
