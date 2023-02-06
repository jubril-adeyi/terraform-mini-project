output "lb_sg_id" {
  value = aws_security_group.lb-sg.id
}
output "server_sg_id" {
  value = aws_security_group.servers-sg.id
}
