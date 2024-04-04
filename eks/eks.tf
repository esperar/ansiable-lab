module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"

    cluster_name = "stw-eks"
    cluster_version = "1.24"

    cluster_endpoint_public_access = true

    cluster_addons = {
        kube-proxy = {
            most_recent = true
        }

        vpc_cni = {
            most_recent = true
            before_compute = true
            service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
            configuration_values = jsonencode({
                 # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
                ENABLE_PREFIX_DELEGATION = "true"
                WARM_PREFIX_TARGET       = "1"
            })
        }
    }

    vpc_id = local.vpc_id
    subnet_ids = local.subnets_ids
    control_plane_subnet_ids = local.private_subnets_ids

    # EKS Managed Node Groups(s)
    eks_managed_node_group_defaults = {
        ami_type = "AL2_x86_64"
        instance_types = ["t3.medium"]
        iam_role_attach_cni_policy = true
    }

    eks_managed_node_groups = {
        stw_node_wg = {
            min_size = 2
            max_size = 6
            desired_size = 2
        }
    }
    
}