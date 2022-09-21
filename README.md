# terraform-aws-eks-lb-controller

[![Lint Status](https://github.com/DNXLabs/terraform-aws-eks-lb-controller/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-eks-lb-controller/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-eks-lb-controller)](https://github.com/DNXLabs/terraform-aws-eks-lb-controller/blob/master/LICENSE)

Terraform module for deploying [AWS Load Balancer Controller](https://github.com/kubernetes-sigs/aws-load-balancer-controller) inside a pre-existing EKS cluster.

## Usage

```
module "load_balancer_controller" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-lb-controller.git"

  cluster_identity_oidc_issuer     = module.eks_cluster.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks_cluster.oidc_provider_arn
  cluster_name                     = module.eks_cluster.cluster_id
}
```

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.13 |
| helm | >= 1.0, < 3.0 |
| kubectl | >= 1.9.4 |
| kubernetes | >= 1.10.0, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.13 |
| helm | >= 1.0, < 3.0 |
| kubectl | >= 1.9.4 |
| kubernetes | >= 1.10.0, < 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| arn\_format | ARNs identifier, usefull for GovCloud begin with `aws-us-gov-<region>`. | `string` | `"aws"` | no |
| cluster\_identity\_oidc\_issuer | The OIDC Identity issuer for the cluster. | `string` | n/a | yes |
| cluster\_identity\_oidc\_issuer\_arn | The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account. | `string` | n/a | yes |
| cluster\_name | The name of the cluster. | `string` | n/a | yes |
| create\_namespace | Whether to create Kubernetes namespace with name defined by `namespace`. | `bool` | `true` | no |
| enabled | Variable indicating whether deployment is enabled. | `bool` | `true` | no |
| helm\_chart\_name | AWS Load Balancer Controller Helm chart name. | `string` | `"aws-load-balancer-controller"` | no |
| helm\_chart\_release\_name | AWS Load Balancer Controller Helm chart release name. | `string` | `"aws-load-balancer-controller"` | no |
| helm\_chart\_repo | AWS Load Balancer Controller Helm repository name. | `string` | `"https://aws.github.io/eks-charts"` | no |
| helm\_chart\_version | AWS Load Balancer Controller Helm chart version. | `string` | `"1.4.4"` | no |
| mod\_dependency | Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable. | `any` | `null` | no |
| namespace | AWS Load Balancer Controller Helm chart namespace which the service will be created. | `string` | `"kube-system"` | no |
| roles | RBAC roles that give secret access in other namespaces to the lb controller | <pre>list(object({<br>    name      = string<br>    namespace = string<br>    secrets   = list(string)<br>  }))</pre> | `[]` | no |
| service\_account\_name | The kubernetes service account name. | `string` | `"aws-alb-ingress-controller"` | no |
| settings | Additional settings which will be passed to the Helm chart values, see https://github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller#configuration. | `any` | `{}` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-eks-lb-controller/blob/master/LICENSE) for full details.
