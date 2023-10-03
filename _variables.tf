variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
}

variable "cluster_identity_oidc_issuer" {
  type        = string
  description = "The OIDC Identity issuer for the cluster."
}

variable "cluster_identity_oidc_issuer_arn" {
  type        = string
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account."
}

variable "helm_chart_name" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "AWS Load Balancer Controller Helm chart name."
}

variable "helm_chart_release_name" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "AWS Load Balancer Controller Helm chart release name."
}

variable "helm_chart_repo" {
  type        = string
  default     = "https://aws.github.io/eks-charts"
  description = "AWS Load Balancer Controller Helm repository name."
}

variable "helm_chart_version" {
  type        = string
  default     = "1.4.4"
  description = "AWS Load Balancer Controller Helm chart version."
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Whether to create Kubernetes namespace with name defined by `namespace`."
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "AWS Load Balancer Controller Helm chart namespace which the service will be created."
}

variable "service_account_name" {
  type        = string
  default     = "aws-alb-ingress-controller"
  description = "The kubernetes service account name."
}

variable "arn_format" {
  type        = string
  default     = "aws"
  description = "ARNs identifier, usefull for GovCloud begin with `aws-us-gov-<region>`."
}

variable "mod_dependency" {
  type        = any
  default     = null
  description = "Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable."
}

variable "settings" {
  type        = any
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values, see https://github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller#configuration."
}

variable "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  type        = string
  default     = null
}

variable "roles" {
  type = list(object({
    name      = string
    namespace = string
    secrets   = list(string)
  }))
  default     = []
  description = "RBAC roles that give secret access in other namespaces to the lb controller"
}

variable "role_name" {
  type        = string
  default     = null
  description = "Optional Parameter to override the naming convention used '<cluster-name>-alb-ingress' role name"
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Optional Parameter to add tags to the lb IAM role"
}