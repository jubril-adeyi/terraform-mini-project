//hosted zone
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

//set record in the hosted zone 
resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.sub_domain_name
  type    = "A"

  alias {
    name                   = var.lb_dns
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}