variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-north-1"
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}


variable "key_name" {
  description = "Name of an existing AWS key pair to use for SSH"
  type        = string
  default     = "Timtee"
}


variable "allowed_cidr" {
  description = "CIDR allowed for SSH (set to your IP)"
  type        = string
  default     = "0.0.0.0/0"
}


variable "librenms_db_root_password" {
  description = "Root password for the MariaDB instance used by LibreNMS"
  type        = string
  default     = "Sentient123&"
}


variable "librenms_admin_user" {
  description = "LibreNMS web admin user"
  type        = string
  default     = "admin"
}


variable "librenms_admin_pass" {
  description = "LibreNMS web admin password"
  type        = string
  default     = "Sentient2use"
}