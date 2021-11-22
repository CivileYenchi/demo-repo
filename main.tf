resource "aws_instance" "sergeEC2" {
  ami = "ami-04ad2567c9e3d7893"
  instance_type ="t2.micro"
  iam_instance_profile = aws_iam_instance_profile.EC2_profile.id
}
resource "aws_iam_role" "EC2_role" {
    name = "S3_Full_access"
     assume_role_policy = jsonencode(
    {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  }
resource "aws_iam_role_policy" "EC2_policy" {
    name = "EC2_Full_Access_S3"
    role = aws_iam_role.EC2_role.id
    policy = jsonencode(
            {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "s3getandputObject",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
        })
}
resource "aws_iam_instance_profile" "EC2_profile" {
    name = "EC2_instance_profile"
    role = aws_iam_role.EC2_role.name
}
