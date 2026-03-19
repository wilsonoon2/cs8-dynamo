resource "aws_iam_policy" "dynamodb" {
  name        = "${var.name_prefix}-policy"
  description = "EC2 access to DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = var.actions
        Resource = var.dynamodb_arn
      }
    ]
  })
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.name_prefix}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.dynamodb.arn
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.name_prefix}-instance-profile"
  role = aws_iam_role.ec2_role.name
}
