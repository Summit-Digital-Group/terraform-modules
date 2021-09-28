
resource "aws_iam_user" "web_deploy" {
  name = "${var.environment}-web-deploy"
}

data "aws_iam_policy_document" "react_deploy" {
  statement {
    actions = ["s3:ListBucket", "s3:PutObject", "s3:DeleteObject"]
    resources = [var.s3_bucket_arn,  "${var.s3_bucket_arn}/*"]
  }
}

data "aws_iam_policy_document" "cloudfront_invalidate" {
  statement {
    actions = ["cloudfront:CreateInvalidation"]
    resources = [var.cloudfront_distro_arn]
  }
}

resource "aws_iam_policy" "react_deploy" {
  name   = "${var.environment}_${var.project_name}_react_deploy"
  policy = data.aws_iam_policy_document.react_deploy.json
}

resource "aws_iam_policy" "cloudfront_invalidate" {
  policy = data.aws_iam_policy_document.cloudfront_invalidate.json
  name   = "${var.environment}_${var.project_name}_cf_invalidate"
}

resource "aws_iam_user_policy_attachment" "react_deploy" {
  policy_arn = aws_iam_policy.react_deploy.arn
  user       = aws_iam_user.web_deploy.name
}

resource "aws_iam_user_policy_attachment" "cloudfront_invalidate" {
  policy_arn = aws_iam_policy.cloudfront_invalidate.arn
  user       = aws_iam_user.web_deploy.name
}
