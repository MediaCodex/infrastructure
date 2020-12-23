/**
 * State storage
 */
resource "aws_s3_bucket" "state" {
  bucket = "mediacodex-${var.prefix}-terraform-state"
  acl    = "private"

  versioning {
    enabled = true
  }

  # remove plans after 30 days
  lifecycle_rule {
    id = "plan"
    enabled = true
    prefix = "plan/"

    expiration {
      days = 30
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket                  = aws_s3_bucket.state.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "state" {
  depends_on = [aws_s3_bucket.state]
  bucket     = aws_s3_bucket.state.id
  policy     = data.aws_iam_policy_document.state.json
}

data "aws_iam_policy_document" "state" {
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
      "${aws_s3_bucket.state.arn}/*"
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
      "${aws_s3_bucket.state.arn}/*"
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

/**
 * State lock
 */
resource "aws_dynamodb_table" "lock" {
  name         = "${var.prefix}-terraform-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}