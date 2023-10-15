packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "my-ami" {
  ami_name        = "my-ami-node${formatdate("YYYY_MM_DD_hh_mm_ss", timestamp())}"
  ami_description = "this ami has node and postgres installed"
  ami_users       = ["363018103404"]
  region          = var.aws_region
  instance_type   = var.instance_type
  source_ami      = var.source_ami
  ssh_username    = var.ssh_username
  subnet_id       = var.subnet_id
}

build {
  sources = ["source.amazon-ebs.my-ami"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install nginx -y",
      "sudo apt-get clean",
      "sudo apt-get install -y unzip"
    ]
  }

  provisioner "file" {
    source      = "./webapp.zip"
    destination = "/home/admin/webapp.zip"
  }

  provisioner "shell" {
    script = "./projsetup.sh"
  }
}