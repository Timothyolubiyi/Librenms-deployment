output "ec2_public_ip" {
  value = aws_instance.librenmsserver.public_ip
}