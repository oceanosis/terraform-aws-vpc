output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = data.aws_subnet.public.id
}

output "private_subnet_id" {
  value = data.aws_subnet.private.id
}