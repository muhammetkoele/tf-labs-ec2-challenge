resource "aws_instance" "tf_instance_public_bastion" {
  subnet_id              = data.aws_subnet.tf_data_subnet.id
  instance_type          = var.ec2_instance_type
  ami                    = data.aws_ami.tf_data_ami.id
  vpc_security_group_ids = [aws_security_group.tf_security_group_allow_traffic_public_instances.id]
  key_name               = var.key_name
  tags = {
    Name = "Public bastion instance"
    Project = "tf-labs-ec2-challenge"
  }
}

resource "aws_instance" "tf_instance_public_dashboard" {
  subnet_id              = data.aws_subnet.tf_data_subnet.id
  instance_type          = var.ec2_instance_type
  ami                    = data.aws_ami.tf_data_ami_ubuntu.id
  vpc_security_group_ids = [aws_security_group.tf_security_group_allow_traffic_public_instances.id]
  key_name               = var.key_name
  user_data              = file("${path.module}/user-data.sh")
  iam_instance_profile   = aws_iam_instance_profile.tf_ec2_instance_profile.name
  tags = {
    Name = "Public dashboard for showing private instance statuses"
    Project = "tf-labs-ec2-challenge"
  }
}

resource "aws_instance" "tf_instance_private" {
  count                  = 3
  subnet_id              = data.aws_subnet.tf_data_subnet1_private.id
  instance_type          = var.ec2_instance_type
  ami                    = data.aws_ami.tf_data_ami.id
  vpc_security_group_ids = [aws_security_group.tf_security_group_allow_traffic_bastion_to_private_instances.id]
  key_name               = var.key_name
  tags = {
    Name = "Private instance ${count.index}"
    Project = "tf-labs-ec2-challenge"
  }
}
