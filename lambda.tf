data "archive_file" "lambda-zip"{
    type = "zip"
    source_dir = "Lambda"
    output_path = "lambda.zip"
}

resource "aws_iam_role" "default" {
  name = "lambda-iam"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda" {
  filename = "lambda.zip"
  function_name = "lambda-function"
  role = aws_iam_role.default.arn
  handler = "lambda.lambda_handler"
  source_code_hash = data.archive_file.lambda-zip.output_base64sha256
  runtime = "python3.8"
}
