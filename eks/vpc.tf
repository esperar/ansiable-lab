module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "stw-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.0.0/22", "10.0.4.0/22", "10.0.8.0/22"]
  public_subnets  = ["10.0.100.0/22", "10.0.104.0/22", "10.0.108.0/22"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

}