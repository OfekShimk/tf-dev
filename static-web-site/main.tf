resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    "Managed via"        = "terraform"
    git_last_modified_by = "oshimko@paloaltonetworks.com"
    git_modifiers        = "ofekshim"
    git_org              = "ofekshim"
    git_repo             = "tf-dev"
  }
}

resource "aws_s3_bucket_object" "this" {
  bucket       = aws_s3_bucket.this.id
  key          = "index.html"
  source       = var.index_path
  content_type = "text/html"

  etag = filemd5(var.index_path)

  tags = {
    "Managed via"        = "terraform"
    git_last_modified_by = "oshimko@paloaltonetworks.com"
    git_modifiers        = "ofekshim"
    git_org              = "ofekshim"
    git_repo             = "tf-dev"
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
      },
    ]
  })
}

