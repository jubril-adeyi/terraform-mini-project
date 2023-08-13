
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "sets the region"
}
variable "ec2_ami" {
  type        = string
  default     = "ami-053b0d53c279acc90"
  description = "machine image for instance creation"
}
variable "access_key" {
  type    = string
  default = ""
}
variable "secret_key" {
  type    = string
  default = ""
}
