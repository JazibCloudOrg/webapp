variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ssh_username" {
  type    = string
  default = "admin"
}

variable "source_ami" {
  type    = string
  default = "ami-06db4d78cb1d3bbf9" #Debian 12 64bit
}

variable "subnet_id" {
  type    = string
  default = "subnet-02926d9d8ad87b0ff"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}