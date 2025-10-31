
# Fetch Default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch Latest Custom AMI
data "aws_ami" "devops_team_ami" {
  owners      = [var.ami_owner_id]
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}