output "cf_distro_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website_distribution.id
}

output "bucket_name" {
  description = "The name of the S3 bucket, which is also the FQDN"
  value       = aws_s3_bucket.website_bucket.id
}
