resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    "Managed via"        = "terraform"
    Environment          = "training"
    git_commit           = "fd646f38c0eda7ce0ab52a4d87493b79e2512474"
    git_file             = "static-web-site/main.tf"
    git_last_modified_at = "2021-08-25 12:13:10"
    git_last_modified_by = "lelbaz@paloaltonetworks.com"
    git_modifiers        = "lelbaz"
    git_org              = "LironElbaz"
    git_repo             = "tf-dev"
    yor_trace            = "e7451a11-6895-417e-b54c-5802399f107d"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
  versioning {
    enabled = "versioning/[0]/enabled:true"
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
    Environment          = "training"
    git_commit           = "fd646f38c0eda7ce0ab52a4d87493b79e2512474"
    git_file             = "static-web-site/main.tf"
    git_last_modified_at = "2021-08-25 12:13:10"
    git_last_modified_by = "lelbaz@paloaltonetworks.com"
    git_modifiers        = "lelbaz"
    git_org              = "LironElbaz"
    git_repo             = "tf-dev"
    yor_trace            = "c4dc6dfc-1562-42cc-ba9c-30b6e78b1cfc"
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

