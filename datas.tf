data "aws_ami" "tf_data_ami" {
  owners = [var.aws_account_id, "amazon"] 
  most_recent = true
  filter {
    name = "name"
    values = [var.aws_ami_name]
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

data "aws_instance" "tf_data_public_bastion" {
  filter {
    name = "tag:Name"
    values = ["Public bastion instance"]
  }
}
