//vpc
module "vpc" {
  source = "../modules/vpc"
  #   cidr_blocks = var.cidr_blocks
  #   aws_region  = var.aws_region
}

//sg
module "sg" {
  source = "../modules/sg"
  vpc_id = module.vpc.vpc_id
}

# // lb 
module "load-balancer" {
  source                = "../modules/aws-lb"
  vpc_id                = module.vpc.vpc_id
  aws_security_group_id = module.sg.lb_sg_id
  subnet1               = module.vpc.subnet1
  subnet2               = module.vpc.subnet2
}

// route53
module "route53" {
  source = "../modules/route53"
  #   domain_name     = var.domain_name
  #   sub_domain_name = var.sub_domain_name
  lb_dns  = module.load-balancer.lb_dns
  zone_id = module.load-balancer.zone_id
}

//ec2  instances setup

provider "aws" {
  region = var.aws_region
#   secret_key = var.secret_key
#   access_key = var.secret_key
}

resource "aws_instance" "server" {
  count = 3

  ami           = var.ec2_ami
  instance_type = "t2.micro"

  tags = {
    Name = "server-${count.index}"
  }
  vpc_security_group_ids      = [module.sg.server_sg_id]
  associate_public_ip_address = true
  subnet_id                   = module.vpc.subnet1
  key_name                    = "key"

  # provisioner "file" {
  #   source      = var.scripts[count.index]
  #   destination = "/home/ubuntu/script.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x script.sh",
  #     "sudo /home/ubuntu/script.sh args"
  #   ]
  # }
}

//Attach instances to target group 

resource "aws_lb_target_group_attachment" "tg-attach1" {
  target_group_arn = module.load-balancer.tg-arn
  target_id        = aws_instance.server[0].id
  port             = 80
}
resource "aws_lb_target_group_attachment" "tg-attach2" {
  target_group_arn = module.load-balancer.tg-arn
  target_id        = aws_instance.server[1].id
  port             = 80
}
resource "aws_lb_target_group_attachment" "tg-attach3" {
  target_group_arn = module.load-balancer.tg-arn
  target_id        = aws_instance.server[2].id
  port             = 80
}


// export the ip addresses of instances into host-inventory file 

resource "local_file" "host-inventory" {
  filename = "host-inventory"
  content = <<EOT
  ${aws_instance.server[0].public_ip}
  ${aws_instance.server[1].public_ip}
  ${aws_instance.server[2].public_ip}
    EOT
}