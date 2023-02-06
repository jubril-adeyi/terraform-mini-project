//ec2 variables
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "sets the region"
}
variable "ec2_ami" {
  type        = string
  default     = "ami-09c583d8b568a9722"
  description = "machine image for instance creation"
}


# // vpc variables 

# variable "aws_region" {
#   type        = string
#   default     = "us-east-1"
#   description = "sets the region"
# }

# variable "cidr_blocks" {
#   type        = string
#   default     = "10.0.0.0/16"
#   description = "vpc CIDR blocks"
# }
# variable "subnets" {
#   type = map(any)
#   default = {
#     subnet-a = {
#       az   = "use1-az1"
#       cidr = "10.0.1.0/24"
#     }
#     subnet-b = {
#       az   = "use1-az2"
#       cidr = "10.0.2.0/24"
#     }
#     subnet-c = {
#       az   = "use1-az3"
#       cidr = "10.0.3.0/24"
#     }
#   }

# }

# # // sg variables 

# variable "inbound_ports" {
#   type        = list(number)
#   default     = [80, 22]
#   description = "ports for the inbound rules"
# }

//lb variables 

# variable "vpc_id" {
# }
# variable "aws_security_group_id" {
# }
# variable "subnet1" {
# }
# variable "subnet2" {
# }
# variable "port" {
#   type    = number
#   default = 80
# }
# variable "protocol" {
#   type    = string
#   default = "HTTP"
# }

# variable "health_check" {
#   type = map(string)
#   default = {
#     "interval"            = "300"
#     "path"                = "/"
#     "timeout"             = "60"
#     "matcher"             = "200"
#     "healthy_threshold"   = "5"
#     "unhealthy_threshold" = "5"
#   }
# }
# variable "listener_port" {
#   type    = number
#   default = 80
# }

# variable "listener_protocol" {
#   type    = string
#   default = "HTTP"
# }

//route53 variables 

# variable "domain_name" {
#   type = string
# }
# variable "sub_domain_name" {
#   type = string
# }

# variable "lb_dns" {}
# variable "zone_id" {}