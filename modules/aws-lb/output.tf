output "lb_dns" {
    value = aws_lb.server-lb.dns_name
}
output "zone_id" {
    value = aws_lb.server-lb.zone_id
}
output "tg-arn"{
  value = aws_lb_target_group.server-tg.arn
}
