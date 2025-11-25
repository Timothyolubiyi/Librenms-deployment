output "public_ip" {
  description = "Public IP of the LibreNMS server"
  value       = aws_instance.librenms.public_ip
}


output "public_dns" {
  description = "Public DNS name of the instance"
  value       = aws_instance.librenms.public_dns
}