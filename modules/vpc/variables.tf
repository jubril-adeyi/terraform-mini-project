
# // vpc variables 


variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "sets the region"
}

variable "cidr_blocks" {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc CIDR blocks"
}
variable "subnets" {
  type = map(any)
  default = {
    subnet-a = {
      az   = "use1-az1"
      cidr = "10.0.1.0/24"
    }
    subnet-b = {
      az   = "use1-az2"
      cidr = "10.0.2.0/24"
    }
    subnet-c = {
      az   = "use1-az3"
      cidr = "10.0.3.0/24"
    }
  }

}

