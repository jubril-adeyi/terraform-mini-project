
# // sg variables 
variable "inbound_ports" {
  type        = list(number)
  default     = [80, 22]
  description = "ports for the inbound rules"
}

variable "vpc_id" {
  type = string
}