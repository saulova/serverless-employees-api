data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rest_api_role" {
  name               = "${local.namespaced_service_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "dynamodb_roles_document" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "dynamodb:ListTables",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${aws_dynamodb_table.this.name}"]
    actions = [
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"
    ]
  }
}

resource "aws_iam_policy" "dynamodb_roles_document" {
  name   = "${local.namespaced_service_name}-policy"
  policy = data.aws_iam_policy_document.dynamodb_roles_document.json
}

resource "aws_iam_role_policy_attachment" "rest_api_dynamo_role" {
  policy_arn = aws_iam_policy.dynamodb_roles_document.arn
  role       = aws_iam_role.rest_api_role.name
}
