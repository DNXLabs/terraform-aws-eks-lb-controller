terraform {
  required_version = "~> 0.13"

  required_providers {
    aws              = ">= 3.13, < 4.0"
    helm             = ">= 1.0, < 1.4.0"
    kubernetes       = ">= 1.10.0"
    kubernetes-alpha = "~> 0.2.1"
  }
}