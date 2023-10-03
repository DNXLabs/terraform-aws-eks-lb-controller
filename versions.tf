terraform {
  required_version = ">= 0.13"

  required_providers {
    aws        = ">= 3.35"
    helm       = ">= 1.0, < 3.0"
    kubernetes = ">= 1.10.0, < 3.0.0"
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.9.4"
    }
  }
}
