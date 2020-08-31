output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_1_subnet_id" {
  value = aws_subnet.main-public-1.id
}
output "public_2_subnet_id" {
  value = aws_subnet.main-public-2.id
}
output "public_3_subnet_id" {
  value = aws_subnet.main-public-3.id
}
output "private_1_subnet_id" {
  value = aws_subnet.main-private-1.id
}
output "private_2_subnet_id" {
  value = aws_subnet.main-private-2.id
}
output "private_3_subnet_id" {
  value = aws_subnet.main-private-3.id
}
