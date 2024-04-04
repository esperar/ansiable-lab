terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "helm" {
    kubernetes {
      host = module.eks.cluster_endpoint
      cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
      exec {
        api_version = "client.authentication.k8s.io/v1alpha1"
        args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
        command = "aws"
      }
    }
}

provider "aws" {
  region = "ap-northeast-2"
}