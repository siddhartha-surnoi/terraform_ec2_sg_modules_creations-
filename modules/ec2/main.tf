resource "aws_instance" "ec2" {
  for_each = var.instance_conf

  ami                    = var.ami_id
  instance_type          = each.value.instance_type
  vpc_security_group_ids = [lookup(var.sg_ids, each.value.security_group, null)]
  root_block_device {
    volume_size = each.value.volume_size
  }

  user_data = each.value.user_data_path != "" ? file(each.value.user_data_path) : null

  tags = merge(var.tags, {
    Name = each.key
  })
}
