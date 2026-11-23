terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Name of an existing EC2 key pair in AWS
variable "key_name" {
  description = "Name of an existing EC2 key pair."
  type        = string
}

# Find the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Find the latest Windows Server 2022 AMI
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Create an Amazon Linux EC2 instance
module "amazon_linux_server" {
  source = "./modules/ec2-templates"

  name     = "amazon-linux-demo"
  ami_id   = data.aws_ami.amazon_linux.id
  key_name = var.key_name

  tags = {
    Environment     = "Lab"
    OperatingSystem = "Amazon Linux"
  }
}

# Create a Windows EC2 instance
module "windows_server" {
  source = "./modules/ec2-templates"

  name          = "windows-demo"
  ami_id        = data.aws_ami.windows.id
  instance_type = "t3.small"
  key_name      = var.key_name

  tags = {
    Environment     = "Lab"
    OperatingSystem = "Windows Server"
  }
}
