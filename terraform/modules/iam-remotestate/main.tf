/**
 * Assumable Role
 */
resource "aws_iam_role" "remotestate" {
  path = "/remotestate/"
  name               = var.service
  description        = "Deployment role for '${var.service}' service"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [var.user]
    }
  }
}

/**
 * Access policy
 */
resource "aws_iam_role_policy" "terraform_state" {
  name   = "TerraformRemoteState"
  role   = aws_iam_role.remotestate.id
  policy = data.aws_iam_policy_document.terraform_state.json
}
data "aws_iam_policy_document" "terraform_state" {
  statement {
    sid = "S3ListObjects"
    actions = [
      "s3:ListBucket"
    ]
    resources = [local.bucket]
  }

  statement {
    sid = "DynamoLock"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [local.table]
  }

  // Development
  statement {
    sid = "DevelopmentS3State"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject"
    ]
    resources = ["${local.bucket}/env:/development/${var.service}.tfstate"]
    condition {
      test = "StringEquals"
      variable = "aws:PrincipalAccount"
      values = [local.account_dev]
    }
  }
}
