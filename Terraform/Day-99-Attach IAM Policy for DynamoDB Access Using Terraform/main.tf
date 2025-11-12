resource "aws_dynamodb_table" "datacenter-table" {
  name           = var.KKE_TABLE_NAME
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
  tags = {
    Name        = var.KKE_TABLE_NAME
  }
}

# IAM Role
resource "aws_iam_role" "datacenter-role" {
  name = var.KKE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy - Read Only Access to the Specific Table
resource "aws_iam_policy" "datacenter-readonly-policy" {
  name        = var.KKE_POLICY_NAME
  description = "Read-only access to DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = aws_dynamodb_table.datacenter-table.arn
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach-policy" {
  role       = aws_iam_role.datacenter-role.name
  policy_arn = aws_iam_policy.datacenter-readonly-policy.arn
}