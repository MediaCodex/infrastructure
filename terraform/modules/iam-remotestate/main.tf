/**
 * Assumable Role
 */
resource "aws_iam_role" "remotestate" {
  for_each = local.workspaces

  path        = "/remotestate/"
  name        = "${each.key}-${var.service}"
  description = "[${each.key}] deployment role for '${var.service}' service"

  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json
}

data "aws_iam_policy_document" "assume_role" {
  for_each = local.workspaces

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [each.value]
    }
  }
}

/**
 * Access policy
 */
resource "aws_iam_role_policy" "terraform_state" {
  for_each = local.workspaces
  name   = "TerraformRemoteState"
  role   = aws_iam_role.remotestate[each.key].id
  policy = data.aws_iam_policy_document.terraform_state[each.key].json
}

data "aws_iam_policy_document" "terraform_state" {
  for_each = local.workspaces

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

  statement {
    sid = "PutStateAndPlans"
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${local.state_bucket}/env:/${each.key}/${var.service}.tfstate",
      "${local.plan_bucket}/${each.key}/${var.service}/*.tfplan"
    ]
  }

  statement {
    sid = "GetStatesAndPlans"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${local.state_bucket}/env:/${each.key}/*.tfstate",
      "${local.plan_bucket}/${each.key}/${var.service}/*.tfplan"
    ]
  }
}
