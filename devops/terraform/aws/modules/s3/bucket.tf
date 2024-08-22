# --> BUCKET USER to access the bucket and Policy (with write permissions)
resource "aws_iam_user" "bucket_user" {
  name = "embalae_s3bucketuser_${var.environment}"

  tags = {
    Name = "embalaebucket"
    Environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "policy" {
  name = "embalae-${var.environment}-s3-access-policy"
  description = "embalae ${var.environment} policy"
  policy = templatefile("s3_policy_bucket_permissions.json", {BUCKET_NAME=var.embalae_aws_s3_bucket})
}

resource "aws_iam_user_policy_attachment" "policy-attach" {
  user       = aws_iam_user.bucket_user.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_access_key" "user_access_key" {
  user = aws_iam_user.bucket_user.name
}


# --> BUCKET 1 for public bucket
resource "aws_s3_bucket" "embalae_s3_bucket_public" {
  bucket = "${var.embalae_aws_s3_bucket}-static"

  tags = {
    Name = "embalaebucket"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket_public_access_block" "embalae_s3_bucket_public" {
  bucket = aws_s3_bucket.embalae_s3_bucket_public.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_cors_configuration" "embalae_s3_bucket_public" {
  bucket = aws_s3_bucket.embalae_s3_bucket_public.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = []
  }
}


resource "aws_s3_bucket_policy" "embalae_s3_bucket_public" {
  bucket = aws_s3_bucket.embalae_s3_bucket_public.id
  policy = templatefile("s3_policy_bucket_public_permissions.json", {BUCKET_NAME=var.embalae_aws_s3_bucket})
  depends_on = [aws_s3_bucket_public_access_block.embalae_s3_bucket_public]
}

# --> BUCKET 2 for media (private)
resource "aws_s3_bucket" "embalae_s3_bucket_media" {
  bucket = var.embalae_aws_s3_bucket

  tags = {
    Name = "embalaebucket"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket_public_access_block" "embalae_s3_bucket_media" {
  bucket = aws_s3_bucket.embalae_s3_bucket_media.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket_cors_configuration" "embalae_s3_bucket_media" {
  bucket = aws_s3_bucket.embalae_s3_bucket_media.id

  cors_rule {
    allowed_origins = ["https://${var.embalae_dns_url}", "http://${var.embalae_dns_url}"]
    allowed_methods = ["PUT", "POST", "DELETE", "GET"]
    expose_headers  = ["ETag", "Accept-Ranges", "Content-Encoding", "Content-Length", "Content-Range"]
    allowed_headers = ["*"]
    max_age_seconds = 86400
  }
}
