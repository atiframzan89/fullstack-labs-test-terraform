# Data Template Shell Script

data "template_file" "node-app-userdata" {
  template = file("${path.module}/templates/node-app-userdata.sh")
}

resource "aws_instance" "node-app-ec2" {
  ami                           = var.ami_id
  instance_type                 = "t2.micro"
  subnet_id                     = var.public-subnet-id-1
  security_groups               = [ aws_security_group.customer-node-app-ec2-sg.id ]
  key_name                      = var.keypair
  associate_public_ip_address   = "true"
  user_data                     = data.template_file.node-app-userdata.rendered
#   user_data                     = data.template_file.backend-userdata.rendered
  root_block_device            {
                                  volume_type = var.root_volume_type
                                  volume_size = var.root_volume_size
                                }
  
  tags = {
      "Name"          = "${var.customer}-node-app-${var.environment}-${var.deployment-version}"
      "Environment"   = var.environment
      "Customer"      = var.customer
      "Terraform"     = "True"
  }
}




# Security Group Section
#########################

resource "aws_security_group" "customer-node-app-ec2-sg" {
    name                = "${var.customer}-bastion-${var.environment}-sg-${var.deployment-version}"
    description         = "${var.customer}-bastion-${var.environment}-sg-${var.deployment-version}"
    vpc_id              = var.vpc-id

  ingress {
    description         = "SSH Port"
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }  
  ingress {
    description         = "NodeJS Port"
    from_port           = 3000
    to_port             = 3000
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
  }          

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
      "Name"          = "${var.customer}-bastion-ec2-${var.environment}-sg-${var.deployment-version}"
      "Environment"   = var.environment
      "Customer"      = var.customer
      "Terraform"     = "True"
  }
  
}

