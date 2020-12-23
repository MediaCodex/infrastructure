/**
 * Assumable Role
 */
resource "aws_iam_role" "remotestate" {
  path        = "/remotestate/"
  name        = var.service
  description = "Deployment role for '${var.service}' service"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = flatten([
        var.user_dev == "" ? [] : [var.user_dev],
        var.user_prod == "" ? [] : [var.user_prod] 
      ])
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
    resources = [local.state_bucket, local.plan_bucket]
  }

  statement {
    sid = "DynamoLock"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [local.lock_table]
  }

  dynamic "statement" {
    for_each = local.workspaces
    content {
      sid  = "${title(statement.key)}PutObjects"

      actions = [
        "s3:PutObject"
      ]

      resources = [
        "${local.state_bucket}/env:/${statement.key}/${var.service}.tfstate",
        "${local.plan_bucket}/${statement.key}/${var.service}/*.tfplan"
      ]

      condition {
        test     = "ArnEquals"
        variable = "aws:PrincipalArn"
        values   = [statement.value]
      }
    }
  }

  dynamic "statement" {
    for_each = local.workspaces
    content {
      sid = "${title(statement.key)}GetObjects"

      actions = [
        "s3:GetObject"
      ]

      resources = [
        "${local.state_bucket}/env:/${statement.key}/*.tfstate",
        "${local.plan_bucket}/${statement.key}/${var.service}/*.tfplan"
      ]

      condition {
        test     = "ArnEquals"
        variable = "aws:PrincipalArn"
        values   = [statement.value]
      }
    }
  }
}
