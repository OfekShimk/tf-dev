output "public_url" {
    value = aws_s3_bucket.this.website_endpoint
}