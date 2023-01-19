resource "aws_security_group" "sg-01" {
  description = "allow http and ssh traffic to network"
  vpc_id      = aws_vpc.vpc-1.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = var.port[1]
    protocol    = "tcp"
    to_port     = var.port[1]
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
    from_port   = var.port[0]
    protocol    = "tcp"
    to_port     = var.port[0]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-01"
  }

}