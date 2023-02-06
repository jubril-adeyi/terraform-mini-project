// lb creation 
resource "aws_lb" "server-lb" {
  name                       = "server-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.aws_security_group_id]
  subnets                    = [var.subnet1, var.subnet2]
  enable_deletion_protection = false
}

// tg creation
resource "aws_lb_target_group" "server-tg" {
  name        = "server-tg"
  target_type = "instance"
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = var.health_check["interval"]
    path                = var.health_check["path"]
    timeout             = var.health_check["timeout"]
    matcher             = var.health_check["matcher"]
    healthy_threshold   = var.health_check["healthy_threshold"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
  }
}



# # Add a listener
resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.server-lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server-tg.arn
  }
}