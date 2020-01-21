locals {
  bucket_name = "mediacodex-terraform-state-" // this is suffixed with a random id
  dynamo_name = "mediacodex-terraform-lock"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = local.bucket_name
  acl           = "private"

  versioning {
    enabled = true
    // TODO: mfa_delete = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.default_tags
}

resource "aws_s3_bucket_policy" "terraform_state" {
  depends_on = [aws_s3_bucket.terraform_state]
  bucket     = aws_s3_bucket.terraform_state.id
  policy     = data.aws_iam_policy_document.prevent_unencrypted_uploads.json
}

data "aws_iam_policy_document" "prevent_unencrypted_uploads" {
  statement {
    sid = "DenyIncorrectEncryptionHeader"

    effect = "Deny"

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "AES256"
      ]
    }
  }

  statement {
    sid = "DenyUnEncryptedObjectUploads"

    effect = "Deny"

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "true"
      ]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = local.dynamo_name
  read_capacity  = 5
  write_capacity = 5

  # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table
  hash_key = "LockID"

  server_side_encryption {
    enabled = true
  }

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.default_tags
}