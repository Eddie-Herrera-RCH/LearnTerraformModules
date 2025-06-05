resource "aws_s3_bucket" "my_bucket_module" {
  bucket = var.bucket_name
  force_destroy = true
  object_lock_enabled = true
  tags = {
    github = "https://github.com/Eddie-Herrera-RCH/LearnTerraformModules.git"
    createdBy = "Terraform"
    date = formatdate("MMM-DD-YYYY", timestamp())
  }
}

data "aws_iam_policy_document" "policy_for_each_bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.aws_arn]
    }

    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "my_policy_attach" {
  bucket = aws_s3_bucket.my_bucket_module.id
  policy = data.aws_iam_policy_document.policy_for_each_bucket.json
}
