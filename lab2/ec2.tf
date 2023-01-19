resource "aws_instance" "public_ec2" {
  ami           = var.ami
  instance_type = var.type
  subnet_id     = aws_subnet.public-subnet.id
  security_groups = [
    aws_security_group.sg-01.id
  ]
  user_data = file("./user_data.sh")
  tags = {
    Name = "public ec2"

  }
}
resource "aws_instance" "private_ec2" {
  ami           = var.ami
  instance_type = var.type
  subnet_id     = aws_subnet.private-subnet.id
  security_groups = [
    aws_security_group.sg-01.id
  ]
  user_data = file("./user_data.sh")
  tags = {
    Name = "private ec2"

  }
}

output "public_ip_ec2" {
  value = aws_instance.public_ec2.public_ip
}
output "private_ip_ec2" {
  value = aws_instance.public_ec2.private_ip

}
output "private_ip_ec2_1" {
  value = aws_instance.private_ec2.private_ip

}

resource "local_file" "ips" {
  content  = aws_instance.public_ec2.public_ip
  filename = "ips.txt"
}