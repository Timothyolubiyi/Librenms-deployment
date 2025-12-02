output "ec2_public_ip" {
  value = aws_instance.jenkinsserver2.public_ip
}