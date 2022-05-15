resource "aws_s3_bucket" "codepipeline" {
}
resource "aws_s3_bucket_acl" "codepipeline" {
  bucket = aws_s3_bucket.codepipeline.id
  acl    = "private"
}
