terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

# Seteamos las credenciales de aws
provider "aws" {
  profile    = "default"
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# # despliegue de la instancia de mongodb
# resource "aws_instance" "elk" {
#   ami           = var.ubuntu_ami
#   instance_type = "t2.large"

#   vpc_security_group_ids = var.elk_sg
#   subnet_id              = var.d_subnet
#   private_ip             = var.elk_priv_ip
#   tags = {
#     Name = "ELK"
#   }
# }

# despliegue de la aplicacion nodejs
resource "aws_instance" "elk_server" {
  ami                    = var.ubuntu_ami
  instance_type          = "t2.large"
  key_name               = var.key_name
  subnet_id              = var.d_subnet
  private_ip             = var.elk_priv_ip
  vpc_security_group_ids = var.elk_sg
  tags = {
    Name = "ELK Server"
  }

  # Crea el archivo hello.js pasando como parametro la ip privada de la instancia de mongodb recien creada
  # copia el archivo app_setup.sh a la instancia desplegada
  # app_setup tiene los comandos bash necesarios para configurar y desplegar la aplicacion
  provisioner "remote-exec" {
    inline = [
      "sudo apt update", 
      "sudo apt install python3 ansible -y", 
      "git clone https://github.com/DanielBerman/ansible-elk-playbook.git && cd ansible-elk-playbook ",
      "ansible-playbook site.yml",
      "echo Done!"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/Downloads/xubuntu.pem")
      host        = self.public_ip
    }
  }
  # provisioner "local-exec" {
  #   command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-elk-playbook -u root -i '${self.private_ip},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' site.yml"
  # }

}
