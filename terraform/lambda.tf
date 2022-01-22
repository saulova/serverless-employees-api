data "archive_file" "utils_layer" {
  output_path = "files/utils-layer.zip"
  type        = "zip"
  source_dir  = "${local.layers_path}/utils"
}

resource "aws_lambda_layer_version" "utils" {
  layer_name          = "utils-layer"
  description         = "utils for response and event"
  filename            = data.archive_file.utils_layer.output_path
  source_code_hash    = data.archive_file.utils_layer.output_base64sha256
  compatible_runtimes = ["nodejs14.x"]
}

data "archive_file" "employees" {
  for_each = local.lambdas

  output_path = "files/${each.key}-employee-artefact.zip"
  type        = "zip"
  source_file = "${local.lambdas_path}/employees/${each.key}.js"
}


resource "aws_lambda_function" "employees" {
  for_each = local.lambdas

  function_name = "dynamodb-${each.key}-item"
  handler       = "${each.key}.handler"
  description   = each.value["description"]
  role          = aws_iam_role.rest_api_role.arn
  runtime       = "nodejs14.x"

  filename         = data.archive_file.employees[each.key].output_path
  source_code_hash = data.archive_file.employees[each.key].output_base64sha256

  timeout     = each.value["timeout"]
  memory_size = each.value["memory"]

  layers = [aws_lambda_layer_version.utils.arn]

  environment {
    variables = {
      TABLE = "employees"
      DEBUG = var.env_type == "dev"
    }
  }
}

resource "aws_lambda_permission" "api" {
  for_each = local.lambdas

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.employees[each.key].arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:*/*"
}

