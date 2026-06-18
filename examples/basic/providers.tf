data "aws_eks_cluster_auth" "eks_cluster" {
  name       = data.aws_eks_cluster.eks_cluster.id
  depends_on = [module.eks.cluster_id]
}

data "aws_eks_cluster" "eks_cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks.cluster_id]
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks_cluster.token
  }
}