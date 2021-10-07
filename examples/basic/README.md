# Basic AWS EKS Cluster + AWS Load Balancer Controller

Configuration in this directory creates a simple EKS cluster with OpenID Connect Provider for EKS enabled IRSA and deploys [AWS Load Balancer Controller](https://github.com/kubernetes-sigs/aws-load-balancer-controller) using terraform helm provider.

This example can be used to do smoke test.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run terraform destroy when you don't need these resources.