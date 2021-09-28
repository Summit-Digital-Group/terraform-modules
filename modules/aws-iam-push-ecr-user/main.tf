resource "aws_iam_user" "deploy" {
  name = "${var.environment}-api-deploy"
}

data "aws_iam_policy_document" "ecr" {
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = [var.ecr_arn]
  }
}

data "aws_iam_policy_document" "ecr_login" {
  statement {
    actions   = ["ecr:GetAuthorizationToken", ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr_deploy" {
  name   = "${var.environment}_${var.project_name}_ecr_deploy"
  policy = data.aws_iam_policy_document.ecr.json
}

resource "aws_iam_policy" "ecr_login" {
  policy = data.aws_iam_policy_document.ecr_login.json
  name   = "${var.environment}_${var.project_name}_ecr_login"
}

resource "aws_iam_user_policy_attachment" "ecr" {
  policy_arn = aws_iam_policy.ecr_deploy.arn
  user       = aws_iam_user.deploy.name
}

resource "aws_iam_user_policy_attachment" "ecr_login" {
  policy_arn = aws_iam_policy.ecr_login.arn
  user       = aws_iam_user.deploy.name
}

data "aws_iam_policy_document" "ecs" {
  statement {
    actions   = ["ecs:UpdateService"]
    resources = [var.ecs_service_id]
  }
}

resource "aws_iam_policy" "ecs_redeploy" {
  name   = "${var.environment}_${var.project_name}_ecs_redeploy"
  policy = data.aws_iam_policy_document.ecs.json
}

resource "aws_iam_user_policy_attachment" "esc" {
  policy_arn = aws_iam_policy.ecs_redeploy.arn
  user       = aws_iam_user.deploy.name
}
