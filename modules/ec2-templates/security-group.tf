
## Security group rules

# Each EC2 instance receives its own security group.

# | Protocol | Port | Purpose                    |
# | -------- | ---: | -------------------------- |
# | TCP      |   22 | SSH access to Amazon Linux |
# | TCP      | 3389 | RDP access to Windows      |
# | TCP      |   80 | HTTP web traffic           |
# | TCP      |  443 | HTTPS web traffic          |
# | ICMP     |  All | Ping requests              |

# Create a security group for this EC2 instance

# Find the default VPC
data "aws_vpc" "default" {
  default = true
}

# Create a security group for this EC2 instance
resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Security group for ${var.name}"
  vpc_id      = data.aws_vpc.default.id

  # SSH - Linux remote access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # RDP - Windows remote access
  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP - Web traffic
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS - Secure web traffic
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ICMP - Ping
  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}
