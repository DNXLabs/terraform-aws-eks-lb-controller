data "aws_availability_zones" "available" {}

locals {
  cluster_name = "test-eks-${random_string.suffix.result}"
  cluster_version = "1.35"

}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                 = "test-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source  = "clouddrove/eks/aws"
  version = "1.4.8"

  name                              = local.cluster_name
  kubernetes_version                = local.cluster_version
  vpc_id                            = module.vpc.vpc_id
  subnet_ids                        = module.vpc.private_subnets
  eks_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]

  # AWS Managed Node Group
  # Default Values for all Node Groups
  managed_node_group_defaults = {
    subnet_ids = module.vpc.private_subnets
    tags = {
      "kubernetes.io/cluster/${module.eks.cluster_name}" = "owned"
      "k8s.io/cluster/${module.eks.cluster_name}"        = "owned"
    }
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size = 50
          volume_type = "gp3"
          iops        = 3000
          throughput  = 150
        }
      }
    }
  }
  managed_node_group = {
    worker-group-1 = {
      name                 = "worker-group-1"
      nodes_additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      capacity_type        = "ON_DEMAND"
      min_size             = 1
      max_size             = 2
      desired_size         = 1
      force_update_version = true
      instance_types       = ["t3.small"]
    }
      worker-group-2 = {
      name                 = "worker-group-2"
      nodes_additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      capacity_type        = "ON_DEMAND"
      min_size             = 1
      max_size             = 1
      desired_size         = 1
      force_update_version = true
      instance_types       = ["t3.medium"]
    }
  }
  apply_config_map_aws_auth = true
  map_additional_iam_users = [
    {
      userarn  = "arn:aws:iam::123456789012:user/hello@clouddrove.com"
      username = "hello@clouddrove.com"
      groups   = ["system:masters"]
    }
  ]
}
