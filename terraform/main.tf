#Providing aws console access.
provider "aws" {
    region     = "us-east-1"
    access_key = "AKIAVS747RU662AAIDVY"
    secret_key = "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"
}

#Initializing the NGINX-Webserver.
resource "aws_instance" "nginx-webserver" {
    ami                    = "ami-0b93ce03dcbcb10f6"
    instance_type          = "t2.micro"
    key_name               = "NGINX-KP"
    user_data = "${file("userdata.sh")}"
    vpc_security_group_ids = [aws_security_group.securitygroup-atto5gc.id]
    subnet_id              = aws_subnet.subnet-atto5gc-public.id
    tags = {
        Name      = "NGINX-Web server"
        CreatedBy = "Tamil"
        Source    = "Terraform"
        env       = "TF-Dev"
    }
}
#Initializing the instance-1 with particular specifications.
resource "aws_instance" "ec2-atto5gc-1" {
    ami                    = "ami-0b93ce03dcbcb10f6"
    instance_type          = "t2.micro"
    key_name               = "ATTOandRANSIM-KP"
    vpc_security_group_ids = [aws_security_group.securitygroup-atto5gc.id]
    subnet_id              = aws_subnet.subnet-atto5gc-public.id

#Mentioning tags for the above resource.
    tags = {
        Name      = "Atto-5GC-1"
        CreatedBy = "Tamil"
        Source    = "Terraform"
        env       = "TF-Dev"
    }
}

#Initializing the instance-2 with particular specifications.
resource "aws_instance" "ec2-atto5gc-2" {
    ami                    = "ami-0b93ce03dcbcb10f6"
    instance_type          = "t2.micro"
    key_name               = "ATTOandRANSIM-KP"
    vpc_security_group_ids = [aws_security_group.securitygroup-atto5gc.id]
    subnet_id              = aws_subnet.subnet-atto5gc-private.id

#Mentioning tags for the above resource.
    tags = {
        Name      = "Atto-5GC-2"
        CreatedBy = "Tamil"
        Source    = "Terraform"
        env       = "TF-Dev"
    }
}

#Creating new VPC with predefined cidr values.
resource "aws_vpc" "vpc-atto5gc" {
  enable_dns_hostnames = true
  enable_dns_support   = true
  cidr_block           = "10.0.0.0/16"

#Mentioning tags for the above resource.
  tags = {
        Name      = "ATTO5Gc-VPC"
        CreatedBy = "Tamil"
        Source    = "Terraform"
        env       = "TF-Dev"
  }
}

#Creating Subnet 
resource "aws_subnet" "subnet-atto5gc-public" {
  vpc_id                  = aws_vpc.vpc-atto5gc.id
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"

#Mentioning tags for the above resource.
  tags = {
        Name      = "ATTO5GC-Subnet-Public-US-EAST-1A"
        CreatedBy = "Tamil"
        Source    = "Terraform"
        env       = "TF-Dev"
  }
}

resource "aws_subnet" "subnet-atto5gc-private" {
    vpc_id            = aws_vpc.vpc-atto5gc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"

#Mentioning tags for the above resource.
    tags = {
        Name      = "ATTO5GC-Subnet-Private-US-EAST-1B"
        CreatedBy = "Tamil"
        Source    = "Terraform"
        env       = "TF-Dev"
    }
}

resource "aws_security_group" "securitygroup-atto5gc" {
    vpc_id      = aws_vpc.vpc-atto5gc.id

#Mentioning tags for the above resource.
    tags = {
        Name      = "ATTO5GC-SecurityGroup"
        CreatedBy = "Tamil"
        Source    = "Terraform"
        env       = "TF-Dev"
    }
  ingress {
    description = "HTTP to Instance"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH to Instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "RDP to Instance"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All traffic allow"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Creating internet gateway for atto5gc-public subnet.
resource "aws_internet_gateway" "internet-gateway-ATTO5GC" {
 vpc_id = aws_vpc.vpc-atto5gc.id

#Mentioning tags for the above resource.
tags = {
  Name      = "ATTO5GC-IGW"
  CreatedBy = "Tamil"
  Source    = "Terraform"
  env       = "TF-Dev"
  }
}

#Creating route tables for atto5gc-public subnet.
resource "aws_route_table" "route-table-ATTO5GC" {
 vpc_id = aws_vpc.vpc-atto5gc.id
 
#Mentioning tags for the above resource.
 tags = {
  Name      = "ATTO5GC-RT"
  CreatedBy = "Tamil"
  Source    = "Terraform"
  env       = "TF-Dev"
  }
}

resource "aws_route" "internetAccess-ATTO5GC-Routes" {
  route_table_id         = aws_route_table.route-table-ATTO5GC.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet-gateway-ATTO5GC.id
}

resource "aws_route_table_association" "route-table-association-to-my-subnet" {
  subnet_id      = aws_subnet.subnet-atto5gc-public.id
  route_table_id = aws_route_table.route-table-ATTO5GC.id
}