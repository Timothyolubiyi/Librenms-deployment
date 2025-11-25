## LibreNMS on EC2 using Terraform ##

This canvas contains a ready-to-run example that provisions an Ubuntu EC2 instance and deploys LibreNMS using Docker Compose via cloud-init (user_data). It includes the Terraform files and a user-data script. Edit variables (especially aws_region, key_name, and any passwords) before applying.

# Files included #

provider.tf — AWS provider and required versions

variables.tf — variables with sensible defaults

security.tf — security group for SSH/HTTP/HTTPS/SNMP

main.tf — EC2 instance (Ubuntu) with cloud-init user_data that installs Docker & Docker Compose and starts LibreNMS with a simple docker-compose.yml

outputs.tf — outputs (public IP, public DNS)

user-data/librenms-cloud-init.sh — the cloud-init script embedded in main.tf (also provided standalone for testing)

README.md — short deployment & post-deploy notes




# LibreNMS on EC2 with Terraform


## Quick steps


1. Edit `variables.tf` to set `key_name`, `allowed_cidr`, and strong passwords (or pass them as `-var` on the CLI).
2. `terraform init`
3. `terraform apply` (or `terraform apply -var 'key_name=your-key' -var 'librenms_db_root_password=Strong!' -auto-approve`)
4. After provisioning, open the `public_ip` output in a browser to finish LibreNMS web setup.


## Notes & next steps
- Replace default passwords before deploying.
- For production: use EBS volumes for persistent storage and backups, enable HTTPS with a proper certificate (Let's Encrypt + reverse proxy), and restrict SNMP and SSH access.
- Consider using RDS for the database in production instead of a containerized DB.


I created a complete Terraform + cloud-init bundle in the canvas titled Librenms-terraform-ec2. It contains the Terraform files, a user-data/cloud-init script that installs Docker & Docker Compose and starts LibreNMS, plus a README with deployment notes.

Next steps you can take now:

Open the canvas (Librenms-terraform-ec2) and edit variables.tf to set your key_name, allowed_cidr, and strong passwords.

Run terraform init and terraform apply from the folder where you save these files.