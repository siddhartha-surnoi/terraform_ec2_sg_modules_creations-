resource "aws_security_group" "this" {
  for_each = var.sg_config

  name        = each.key
  description = each.value.desc
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = each.value.ports
    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.allowed_cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${each.key}-sg"
  })
}
