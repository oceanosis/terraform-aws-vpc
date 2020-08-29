# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "main"
    }
    lifecycle {
        create_before_destroy = true
    }
}

# Subnets
resource "aws_subnet" "main-public-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = var.availability_zone_names[0]

    tags = {
        Name = "main-public-1"
        Tier = "Public"
    }
    depends_on = [aws_vpc.main]

}
resource "aws_subnet" "main-public-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = var.availability_zone_names[1]

    tags = {
        Name = "main-public-2"
        Tier = "Public"
    }

    depends_on = [aws_vpc.main]

}
resource "aws_subnet" "main-public-3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = var.availability_zone_names[2]

    tags = {
        Name = "main-public-3"
        Tier = "Public"
    }

    depends_on = [aws_vpc.main]

}
resource "aws_subnet" "main-private-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.101.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = var.availability_zone_names[0]

    tags = {
        Name = "main-private-1"
        Tier = "Private"
    }
    depends_on = [aws_vpc.main]
}
resource "aws_subnet" "main-private-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.102.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = var.availability_zone_names[1]

    tags = {
        Name = "main-private-2"
        Tier = "Private"
    }
    depends_on = [aws_vpc.main]
}
resource "aws_subnet" "main-private-3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.103.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = var.availability_zone_names[2]

    tags = {
        Name = "main-private-3"
        Tier = "Private"
    }
    depends_on = [aws_vpc.main]
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-public-gw"
    }
    depends_on = [aws_vpc.main]
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }

    tags = {
        Name = "main-public-gw"
    }
    depends_on = [aws_internet_gateway.main-gw]

}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
    subnet_id = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-2-a" {
    subnet_id = aws_subnet.main-public-2.id
    route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-3-a" {
    subnet_id = aws_subnet.main-public-3.id
    route_table_id = aws_route_table.main-public.id
}

resource "aws_eip" "nat-ip" {
  vpc      = true
}

# NAT GW for private
resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.nat-ip.id
    subnet_id     = aws_subnet.main-public-1.id
    tags = {
        Name = "main-nat-gw"
    }
}

# route tables
resource "aws_route_table" "main-private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat-gw.id
    }
    tags = {
        Name = "main-private"
    }
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
    subnet_id = aws_subnet.main-private-1.id
    route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "main-private-2-a" {
    subnet_id = aws_subnet.main-private-2.id
    route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "main-private-3-a" {
    subnet_id = aws_subnet.main-private-3.id
    route_table_id = aws_route_table.main-private.id
}
