resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Terraform-AWS"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "public-subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    
    tags = {
      Name = "private-subnet"
    }  
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-igw"
    }
}

resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.main.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.id 
    }
    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public-rt.id
  
}

resource "aws_security_group" "public-sg" {
    name = "public-sg"
    vpc_id = aws_vpc.main.id

    ingress = [ 
      {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        description = "ssh"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port = 80
        to_port =80
        protocol = "tcp"
        description = "http"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]

    tags = {
        Name = "public-sg"
    }     
}

