variable "bucket_name" {
  type = string
}

variable "attach_policy" {
  type    = bool
  default = false
}

variable "bucket_policy" {
  type    = string
  default = ""
}
