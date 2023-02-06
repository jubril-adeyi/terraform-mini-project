resource "aws_security_group" "lb-sg" {
  name        = "lb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "inbound traffic for http"
    from_port   = var.inbound_ports[0]
    to_port     = var.inbound_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "servers-sg" {
  name        = "servers-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "inbound traffic for SSH"
    from_port   = var.inbound_ports[1]
    to_port     = var.inbound_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "inbound traffic for HTTP"
    from_port       = var.inbound_ports[0]
    to_port         = var.inbound_ports[0]
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

