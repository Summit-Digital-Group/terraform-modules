resource "random_password" "this" {
  length = 10
}

data "archive_file" "lambda_function" {
  type = "zip"
  source {
    content  = templatefile("${path.module}/lambda/index.js", { username = local.username, password = local.password, realm = var.realm })
    filename = "index.js"
  }
  output_path = local.archive_output_path
}

resource "aws_iam_role" "this" {
  name_prefix        = local.name_prefix
  tags               = local.tags
  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Principal": {
            "Service": [
               "lambda.amazonaws.com",
               "edgelambda.amazonaws.com"
            ]
         },
         "Action": "sts:AssumeRole"
      }
   ]
}
EOF
}
resource "aws_iam_policy" "lambda_logging" {
  name_prefix = local.name_prefix
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${local.lambda_name}"
  retention_in_days = var.retention_in_days
  tags              = local.tags
}

resource "aws_cloudwatch_log_stream" "this" {
  log_group_name = aws_cloudwatch_log_group.this.name
  name           = local.lambda_name
}

resource "random_pet" "this" {}

resource "aws_lambda_function" "this" {
  depends_on       = [data.archive_file.lambda_function, aws_cloudwatch_log_group.this, aws_iam_role_policy_attachment.lambda_logs]
  filename         = data.archive_file.lambda_function.output_path
  function_name    = local.lambda_name
  role             = aws_iam_role.this.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(data.archive_file.lambda_function.output_path)
  runtime          = "nodejs12.x"
  publish          = true
  tags             = local.tags
}
