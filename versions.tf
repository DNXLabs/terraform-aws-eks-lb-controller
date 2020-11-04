terraform {
  required_version = "~> 0.13.0"

  required_providers {
    aws              = ">= 2.0, < 4.0"
    helm             = ">= 1.0, < 1.4.0"
    kubernetes       = ">= 1.10.0"
    local            = "~> 1.2"
    null             = "~> 2.0"
    kubernetes-alpha = "~> 0.2.1"
  }
}