output "vpc_id" {
  value = aws_vpc.server-vpc.id
}

output "route_table" {
  value = aws_route_table.server-rt.id
}

output "internet_gateway" {
  value = aws_internet_gateway.gw.id
}
output "subnet1" {
  value = aws_subnet.server-subnets1.id
}
output "subnet2" {
  value = aws_subnet.server-subnets2.id
}