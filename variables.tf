# Credentials
variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "key_name" {
  type    = string
  default = "xubuntu"
}

variable "ubuntu_ami" {
  type    = string
  default = "ami-04505e74c0741db8d"
}

variable "d_subnet" {
  type    = string
  default = "subnet-03b51fa22c07c43de"
}

variable "elk_sg" {
  type    = list(string)
  default = ["sg-06e85e41c89593e17"]
}

variable "elk_priv_ip" {
  type    = string
  default = "172.31.101.21"
}

variable "app_priv_ip" {
  type    = string
  default = "172.31.101.11"
}

variable "apm_priv_ip" {
  type    = string
  default = "172.31.101.31"
}
