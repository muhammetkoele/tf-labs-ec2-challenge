resource "aws_iam_role" "tf_iam_role_for_public_dashboard" {
  name = "EC2-instance-specific-role"
  assume_role_policy = data.aws_iam_policy_document.tf_assume_role_policy_for_instance.json
  # Define which accounts or AWS services can assume the role.

  tags = {
    Name    = "IAM role for public dashboard instance"
    Project = "tf-labs-ec2-challenge"
  }
}

data "aws_iam_policy_document" "tf_assume_role_policy_for_instance" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "tf_ec2_read_only_access" {
  role = aws_iam_role.tf_iam_role_for_public_dashboard.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "tf_ec2_instance_profile" {
  name = "EC2-instance-profile"
  role = aws_iam_role.tf_iam_role_for_public_dashboard.name
  
  tags = {
    Name    = "EC2 instance profile public dashboard instance"
    Project = "tf-labs-ec2-challenge"
  }
}
