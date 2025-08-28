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

// Server information
variable "minio_server_hostname" {
  description = "The server hostname of the Minio instance"
  type        = string
  default     = "s3.storage.home.arpa"
}

variable "minio_server_port" {
  description = "The port of the Minio instance"
  type        = number
  default     = 9000
}

variable "minio_server_protocol" {
  description = "The protocol of the Minio instance"
  type        = string
  default     = "https"
}

variable "bucket_configurations" {
  type = list(object({
    buckets = list(string)
    user_name   = string
    group_name  = string

    access_key = string
    secret_key = string
    policy     = string
    lifecycle_policy = optional(string)
  }))
  description = <<EOT
List of bucket configurations, each containing bucket names, user name, group name,
access key, secret key, policy, and optionally a lifecycle_policy.
EOT
}
