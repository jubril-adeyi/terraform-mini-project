//lb variables 

variable "vpc_id" {
}
variable "aws_security_group_id" {
}
variable "subnet1" {
}
variable "subnet2" {
}
variable "port" {
  type    = number
  default = 80
}
variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check" {
  type = map(string)
  default = {
    "interval"            = "300"
    "path"                = "/"
    "timeout"             = "60"
    "matcher"             = "200"
    "healthy_threshold"   = "5"
    "unhealthy_threshold" = "5"
  }
}
variable "listener_port" {
  type    = number
  default = 80
}
  
variable "listener_protocol" {
  type    = string
  default = "HTTP"
 
}