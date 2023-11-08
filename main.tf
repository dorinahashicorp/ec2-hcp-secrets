terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
    }
    hcp = {
      source = "hashicorp/hcp"
      version = "0.76.0"
    }
  }
  }

data "hcp_vault_secrets_secret" "access_key" {
  app_name    = "Learning-app"
  secret_name = "AWS_ACCESS_KEY_ID"
}

data "hcp_vault_secrets_secret" "secret_key" {
  app_name    = "Learning-app"
  secret_name = "AWS_SECRET_ACCESS_KEY"
}

provider "aws" {
  region = "us-west-2"
  access_key = data.hcp_vault_secrets_secret.access_key.secret_value
  secret_key = data.hcp_vault_secrets_secret.secret_key.secret_value
}

resource "aws_instance" "My-VM" {
  ami           = "ami-00448a337adc93c05"
  instance_type = "t2.micro"
}
