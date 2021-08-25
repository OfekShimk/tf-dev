provider "aws" {
  region = "eu-west-1"
  profile = "dev3"
}

module "static_web_site" {
  source        = "./static-web-site"

  index_path    = "index.html"
  bucket_name   = "lirons-bucket"
}