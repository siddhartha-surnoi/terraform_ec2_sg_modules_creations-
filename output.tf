output "security_groups" {
  value = module.security_groups.sg_ids
}

output "ec2_instances" {
  value = {
    public_ips  = module.ec2_instances.instance_public_ips
    private_ips = module.ec2_instances.instance_private_ips
  }
}
