provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "kurepin-tf-state"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kurepin-tf-state-locks"
    encrypt        = true

  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  allocated_storage   = 10
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  password            = var.db_password
  skip_final_snapshot = "true"
}
