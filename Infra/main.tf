data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = var.vpc_name
  cidr = var.cidr_block

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = var.tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.eks_version

  vpc_id = module.vpc.vpc_id

  create_iam_role                     = true
  attach_cluster_encryption_policy    = false

  cluster_endpoint_public_access      = true
  cluster_endpoint_private_access     = true

  control_plane_subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

  create_cluster_security_group       = true
  cluster_security_group_description  = "EKS cluster security group"

  bootstrap_self_managed_addons       = true

  authentication_mode                 = "API"
  enable_cluster_creator_admin_permissions = true

  dataplane_wait_duration             = "40s"

  enable_security_groups_for_pods     = true

  create_cloudwatch_log_group         = false
  create_kms_key                      = false
  enable_kms_key_rotation             = false
  kms_key_enable_default_policy       = false
  enable_irsa                         = false
  cluster_encryption_config           = {}
  enable_auto_mode_custom_tags        = false

  create_node_security_group                  = true
  node_security_group_enable_recommended_rules = true
  node_security_group_description              = "EKS node group security group - used by nodes to communicate with the cluster API"
  node_security_group_use_name_prefix          = true

  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    group1 = {
      name           = "demo-eks-node-group"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 4
      desired_size = 2
    }
  }
}

resource "aws_iam_user_policy_attachment" "eks_cluster_policy" {
  user       = var.eks_admin_user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_user_policy_attachment" "eks_worker_policy" {
  user       = var.eks_admin_user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_user_policy_attachment" "eks_cni_policy" {
  user       = var.eks_admin_user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = module.eks.eks_managed_node_groups["group1"].iam_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])

    mapUsers = yamlencode([
      {
        userarn  = var.eks_admin_user_arn
        username = var.eks_admin_user_name
        groups   = ["system:masters"]
      }
    ])
  }
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_name}"
  }

  depends_on = [module.eks]
}