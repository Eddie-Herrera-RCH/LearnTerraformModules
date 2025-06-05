terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.preferred_region
}

data "aws_iam_policy_document" "per_bucket" {
  for_each = var.s3_bucket_list

  statement {
    principals {
      type        = "AWS"
      identifiers = [var.aws_arn]
    }
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${each.value}",
      "arn:aws:s3:::${each.value}/*"
    ]
  }
}

# Call s3bucket module once per bucket
module "s3_buckets_create" {
  source   = "./modules/s3bucket"
  for_each = toset(var.s3_bucket_list)
  bucket_name = each.key
}