module "vpc" {
  source = "./modules/vpc"

  vpc_name        = var.vpc_name
  cidr            = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  intra_subnets   = var.intra_subnets

}

module "eks" {
  source = "./modules/eks"

  cluster_name             = var.cluster_name
  vpc_id                   = module.vpc.vpc_id
  private_subnets          = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets
  azs                      = var.azs
}
