resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "terraform bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "s3_object" {

  bucket   = aws_s3_bucket.s3_bucket.bucket
  for_each = fileset("../public/images", "**")
  key      = "images/${each.key}"
  source   = "../public/images/${each.key}"
}