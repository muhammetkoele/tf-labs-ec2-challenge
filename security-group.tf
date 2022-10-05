resource "aws_security_group" "tf_security_group_allow_traffic_public_instances" {

  name        = "tf_security_group_allow_traffic_public_instance"
  description = "Security group to control traffic"
  vpc_id      = data.aws_vpc.tf_data_vpc.id

  ingress {
    description = "Allow incoming SSH connection"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # accept from everywhere
  }

  egress {
    description = "Allow access to the internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # means TCP + UDP
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security group for public bastion instance"
    Project = "tf-labs-ec2-challenge"
  }
}


resource "aws_security_group" "tf_security_group_allow_traffic_bastion_to_private_instances" {

  name        = "tf_security_group_allow_traffic_bastion_to_private_instances" 
  description = "Security group to control traffic from bastion to private instances"
  vpc_id      = data.aws_vpc.tf_data_vpc.id

  ingress {
    description = "Allow incoming SSH connection from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks = ["${data.aws_instance.tf_data_public_bastion.private_ip}/32"]
    security_groups = [aws_security_group.tf_security_group_allow_traffic_public_instances.id]
  }

  tags = {
    Name = "Security group for private instances" 
    Project = "tf-labs-ec2-challenge"
  }
}
