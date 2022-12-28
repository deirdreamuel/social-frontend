output "website_bucket_name" {
  description = "Website Files S3 Bucket Name"

  value = aws_s3_bucket.site.id
}

output "cloudfront_domain_name" {
  description = "CloudFront Domain Name"

  value = aws_cloudfront_distribution.site.domain_name
}