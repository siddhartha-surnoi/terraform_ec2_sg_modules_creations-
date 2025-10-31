####################################################
# AWS Configuration
####################################################

variable "region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-east-1"
}

####################################################
# Project Metadata
####################################################

variable "Project_name" {
  description = "Project name"
  type        = string
  default     = "FusionIQ"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "developed_by" {
  description = "Developer or maintainer name"
  type        = string
  default     = "Siddhartha"
}

####################################################
# AMI Configuration
####################################################

variable "ami_owner_id" {
  description = "AWS Account ID that owns the AMI"
  type        = string
  default     = "794383793382"
}

variable "ami_name_pattern" {
  description = "AMI name pattern for lookup"
  type        = string
  default     = "DevOps-Team-ami-*"
}

####################################################
# Networking Configuration
####################################################

variable "allowed_cidr" {
  description = "Allowed CIDR for inbound traffic"
  type        = string
  default     = "0.0.0.0/0"
}

####################################################
# Security Group Configuration
####################################################

variable "security_groups" {
  description = "Security groups configuration"
  type = map(object({
    desc  = string
    ports = list(number)
  }))

  default = {
    jenkins = {
      desc  = "Security group for Jenkins Master"
      ports = [22, 8080]
    }
    aiml = {
      desc  = "Security group for AIML servers"
      ports = [22, 6379, 8000, 8001, 8002, 8003]
    }
    nginx = {
      desc  = "Security group for Nginx"
      ports = [22, 80]
    }
    backend = {
      desc  = "Security group for backend servers"
      ports = [22, 8080, 8081, 8082, 8083, 8084, 8085, 8086, 8087, 8761]
    }
  }
}


####################################################
# EC2 Configuration
####################################################

variable "instance_configs" {
  description = "Configuration for EC2 instances"
  type = map(object({
    instance_type  = string
    volume_size    = number
    user_data_path = string
    security_group = string
  }))

  default = {
    jenkins-master = {
      instance_type  = "t3.small"
      volume_size    = 20
      user_data_path = "script/jenkins_master.sh"
      security_group = "jenkins"
    }
    AIML = {
      instance_type  = "t3.small"
      volume_size    = 30
      user_data_path = "script/aiml_script.sh"
      security_group = "aiml"
    }
    nginx = {
      instance_type  = "t3.micro"
      volume_size    = 10
      user_data_path = "script/nginx_script.sh"
      security_group = "nginx"
    }
    backend = {
      instance_type  = "t3.micro"
      volume_size    = 10
      user_data_path = "script/backend_script.sh"
      security_group = "backend"
    }
  }
}
