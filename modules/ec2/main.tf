provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "server" {
  count = 3

  ami           = var.ec2_ami
  instance_type = "t2.micro"

  tags = {
    Name = "server-${count.index}"
  }
  vpc_security_group_ids      = [aws_security_group.servers-sg.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.server-subnets1.id
}