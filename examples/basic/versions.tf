terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws        = ">= 3.13.0"
    local      = ">= 1.4"
    random     = ">= 2.1"
    kubernetes = "~> 1.10"
    helm       = ">= 1.0"
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.9.4"
    }
  }
}