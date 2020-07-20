aws_region = "eu-west-2"
vpc_cidr_block = "10.0.0.0/16"
vpc_name_tag = "terraform_vpc"

terraform_IGW = "terraform_IGW"
terraform_rt_tag_name = "terraform_rt"

terraform_rt_cidr_block = "0.0.0.0/0"

terraform_nat_tag_name = "terraform_NAT"

web_ami = "ami-04122be15033aa7ec"
instance_type = "t2.micro"
public_web_tag_name = "terraform_public_web"
private_web_tag_name = "terraform_private_instance"

public_subnet_name_tag = "public_subnet"
private_subnet_name_tag = "private_subnet"
dynamo_db = "terraform-locks"