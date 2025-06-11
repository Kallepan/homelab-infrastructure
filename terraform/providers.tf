terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
    }

    minio = {
      source = "aminueza/minio"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubernetes_config_path
  }
}

provider "kubernetes" {
  config_path = var.kubernetes_config_path
}

provider "kubectl" {
  config_path = var.kubernetes_config_path
}

provider "minio" {
  minio_server   = "s3.storage.home.arpa:9000"
  minio_region   = "eu-west-1"
  minio_user     = var.minio_user
  minio_password = var.minio_password
  minio_ssl      = true
}