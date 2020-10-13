provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
}
resource "aws_key_pair" "demo_key" {
  key_name   = "myPublicKey"
  public_key = "${file(var.public_key)}"
}

resource "aws_instance" "Instances" {
  ami                    = var.ami
  count                  = var.instance-count
  instance_type          = var.instance-type
  key_name               = var.pem-key
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = true


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name  =  "${element(var.tags, count.index)}"
  }

  associate_public_ip_address = var.associate_public_ip_address

}

resource "local_file" "ansible_inventory" {
  filename = "inventory.ini"
  content = <<EOT
[jenkins]
ubuntu@${aws_instance.Instances[0].public_dns}

[testVM]
ubuntu@${aws_instance.Instances[1].public_dns}

[all:vars]
ansible_ssh_private_key_file="./ansible-jenkins.pem"
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter="/usr/bin/python3"
  EOT


provisioner "local-exec"{
  command = <<EOF
  ansible-playbook --private-key "ansible-jenkins.pem" -i "./inventory.ini" ./EC2/jenkinsplaybook.yaml

  EOF

}
}


