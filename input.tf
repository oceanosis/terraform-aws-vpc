
variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "az" {
  default = "eu-west-2a"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["eu-west-2a","eu-west-2b","eu-west-2c"]
}

variable "private_subnet_count" {
  default = 1
}
variable "public_subnet_count" {
  default = 1
}