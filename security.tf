#Create security group for Application LB to allow http and https 
resource "aws_security_group" "ec2-sg" {
  name = "ec2-sg"
  #vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_open]
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_open]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_open]
  }

  egress {
    description = "Outgoing"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_open]
  }

  tags = {
    Name = "ec2-sg"
  }
}

