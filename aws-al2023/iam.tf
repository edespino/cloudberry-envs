# Create IAM Role for EC2
resource "aws_iam_role" "ec2_ecr_role" {
  name = "EC2ECRRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Create a custom policy for ECR Public access
resource "aws_iam_policy" "ecr_public_policy" {
  name        = "ECRPublicAccessPolicy"
  description = "Policy to allow EC2 instance to interact with Amazon ECR Public"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr-public:GetAuthorizationToken",
          "ecr-public:BatchCheckLayerAvailability",
          "ecr-public:GetDownloadUrlForLayer",
          "ecr-public:GetRepositoryPolicy",
          "ecr-public:InitiateLayerUpload",
          "ecr-public:UploadLayerPart",
          "ecr-public:CompleteLayerUpload",
          "ecr-public:PutImage",
          "sts:GetServiceBearerToken"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the ECR Public policy to the IAM role
resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role       = aws_iam_role.ec2_ecr_role.name
  policy_arn = aws_iam_policy.ecr_public_policy.arn
}

# Create an Instance Profile and associate it with the IAM Role
resource "aws_iam_instance_profile" "ec2_ecr_instance_profile" {
  name = "EC2ECRInstanceProfile"
  role = aws_iam_role.ec2_ecr_role.name
}
