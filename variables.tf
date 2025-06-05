variable "preferred_region" {
    type = string
    default = "us-east-1"
}

variable "s3_bucket_list" {
    type = list(string)
}

variable "aws_arn" {
    type = string
}

variable "ec2_list" {
    type = list(string)
}