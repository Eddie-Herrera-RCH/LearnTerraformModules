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

# Call s3bucket module once per bucket
module "s3_buckets_create" {
  source   = "./modules/s3module"
  for_each = toset(var.s3_bucket_list)
  aws_arn = var.aws_arn
  bucket_name = each.key
}

module "launch_ec2s" {
  source = "./modules/ec2module"
  for_each = toset(var.ec2_list)
  instance_name = each.key
}