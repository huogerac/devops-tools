output "access_key_id" {
  description = "The value to be stored into your app to access the new bucket"
  value = aws_iam_access_key.user_access_key.id
}

output "secret_access_key" {
  description = "The value to be stored into your app to access the new bucket"
  value = aws_iam_access_key.user_access_key.secret
  sensitive = true
}

output "bucket_public" {
    description = "Bucket public for django static files (Public)"
    value = aws_s3_bucket.embalae_s3_bucket_public.id
}

output "bucket_private" {
    description = "Bucket private for django media files (Private)"
    value = aws_s3_bucket.embalae_s3_bucket_media.id
}
