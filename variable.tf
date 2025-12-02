variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "avail_zone" {}
variable "env_prefix" {}
variable "instance_type" {}
variable "ami" {}
variable "region" {}
variable "cidr_open" {
  description = "CIDR block to allow open access"
  type        = string
  default     = "0.0.0.0/0"
}