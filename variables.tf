variable "aws_account_id" {
  description = "AWS Account ID to use for ec2-challenge"
  type = string
}

variable "aws_ami_name" {
  description = "Name of the ami for ec2-challenge"
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "key_name" {
  type = string
}
