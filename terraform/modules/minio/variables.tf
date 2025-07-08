### Minio Configuration Variables ###
variable "minio_user" {
  description = "The user for Minio"
  type        = string
  sensitive   = true
}

variable "minio_password" {
  description = "The password for Minio"
  type        = string
  sensitive   = true
}

variable "bucket_configurations" {
  type = list(object({
    buckets = list(string)
    user_name   = string
    group_name  = string

    access_key = string
    secret_key = string
    policy     = string
  }))
  description = "List of bucket configurations, each containing bucket names, user name, group name, access key, secret key, and policy."
}
