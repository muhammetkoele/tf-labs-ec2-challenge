data "aws_ami" "tf_data_ami" {
  owners = [var.aws_account_id, "amazon"] 
  most_recent = true
  filter {
    name = "name"
    values = [var.aws_ami_name]
  }
}

data "aws_ami" "tf_data_ami_ubuntu" {
  owners = [var.aws_account_id, "amazon"] 
  most_recent = true
  filter {
    name = "name"
    values = [var.aws_ami_name_ubuntu]
  }
}

data "aws_vpc" "tf_data_vpc" {
  filter {
    name   = "tag:Name"
    values = ["Main VPC created through Terraform"]
  }
}

data "aws_subnet" "tf_data_subnet" {
  filter {
    name   = "tag:Name"
    values = ["Public Subnet 1"]
  }
}

data "aws_subnet" "tf_data_subnet1_private" {
  filter {
    name   = "tag:Name"
    values = ["Private Subnet 1"]
  }
}

data "aws_secretsmanager_secret" "tf_ec2_challenge_user_credentials"{
    name = "ec2-challenge-user-credentials"
}

data "aws_secretsmanager_secret_version" "tf_ec2_challenge_user_credentials_secret_version"{
    secret_id = data.aws_secretsmanager_secret.tf_ec2_challenge_user_credentials.id
}

output "ec2-challenge-user-access-key-id" {
    value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.tf_ec2_challenge_user_credentials_secret_version.secret_string))["ec2-challenge-access-key-id"]
    sensitive = true # remove if you want to see value on terminal
}

output "ec2-challenge-secret-access-key" {
    value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.tf_ec2_challenge_user_credentials_secret_version.secret_string))["ec2-challenge-secret-access-key"]
    sensitive = true
}
