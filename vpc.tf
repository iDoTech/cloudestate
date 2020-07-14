# Configure the AWS provider
provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"

}

# VPC Creation part
resource "aws_vpc" "main" {
  cidr_block  = "10.0.0.0/16"
  tags = {
    Name = "second-VPC"
  }
}

#Subnet Creation part
resource "aws_subnet" "subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "second-Subnet"
  }
}

#Internet Gateway Creation part
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "second-igw"
  }
}

#Route Table Creation part
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
#  route {
#    cidr_block = "10.0.1.0/24"
#    gateway_id = aws_internet_gateway.igw.id
#  }
  tags = {
  Name = "second RT"
  }
}
