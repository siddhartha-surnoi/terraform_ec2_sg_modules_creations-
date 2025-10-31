# Security Group Module calling
module "security_groups" {
  source       = "./modules/sg"
  vpc_id       = data.aws_vpc.default.id
  allowed_cidr = var.allowed_cidr
  sg_config    = var.security_groups
  tags         = local.common_tags
}

# EC2 Module calling
module "ec2_instances" {
  source        = "./modules/ec2"
  ami_id        = data.aws_ami.devops_team_ami.id
  instance_conf = var.instance_configs
  sg_ids        = module.security_groups.sg_ids
  tags          = local.common_tags

}
