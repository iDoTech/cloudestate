provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name_tag
  }
}
resource "aws_subnet" "public_subnets" {
  vpc_id     = aws_vpc.main.id
  count = length(var.public_subnet_cidr_block)
  cidr_block = lookup(var.public_subnet_cidr_block, count.index) 

  tags = {
    Name = "${var.public_subnet_name_tag}${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.main.id
  count = length(var.private_subnet_cidr_block)
  cidr_block = lookup(var.private_subnet_cidr_block, count.index) 

  tags = {
    Name = "${var.private_subnet_name_tag}${count.index + 1}"
  }
}

resource "aws_internet_gateway" "terraform_IGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.terraform_IGW
  }
}
resource "aws_route_table" "terraform_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.terraform_rt_cidr_block
    gateway_id = aws_internet_gateway.terraform_IGW.id
  }
  tags = {
    Name = var.terraform_rt_tag_name
  }
}

resource "aws_route_table_association" "rt_subnet_association" {
  count          = length(aws_subnet.public_subnets.*.id)
  subnet_id      = element( aws_subnet.public_subnets.*.id , count.index)
  route_table_id = aws_route_table.terraform_rt.id
}

#resource "aws_route_table_association" "rt_private_subnet_association" {
#  count          = length(aws_subnet.private_subnets.*.id)
#  subnet_id      = element( aws_subnet.private_subnets.*.id , count.index)
#  route_table_id = aws_route_table.terraform_rt.id
#}

resource "aws_eip" "terraform_eip" {  
}
resource "aws_nat_gateway" "terraform_NAT" {
  allocation_id = aws_eip.terraform_eip.id
  subnet_id     = aws_subnet.private_subnets.0.id

  tags = {
    Name = var.terraform_nat_tag_name
  }
}
#resource "aws_instance" "terraform_public_web" {
#  ami           = var.web_ami
#  instance_type = var.instance_type
#  subnet_id     = aws_subnet.public_subnet_1.id
#  associate_public_ip_address =  true
#  tags = {
#    Name = var.public_web_tag_name
#  }
#}
#resource "aws_instance" "terraform_private_instance" {
#  ami           = var.web_ami
#  instance_type = var.instance_type
#  subnet_id     = aws_subnet.private_subnet_1.id
#  tags = {
#    Name = var.private_web_tag_name
#  }
#}
