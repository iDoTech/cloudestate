variable "aws_region" {}
variable "vpc_cidr_block" {}
variable "vpc_name_tag" {}

variable "public_subnet_cidr_block" { default= {  "0" = "10.0.1.0/24", "1" = "10.0.2.0/24", "2" = "10.0.3.0/24" }}

variable "private_subnet_cidr_block" {default= { "0" = "10.0.10.0/24", "1" = "10.0.20.0/24","2" =  "10.0.30.0/24"}}

variable "public_subnet_name_tag" {}
variable "private_subnet_name_tag" {}

variable "terraform_IGW" {}
variable "terraform_rt_tag_name" {}

variable "terraform_rt_cidr_block" {}

variable "terraform_nat_tag_name" {} 

variable "web_ami" {} 
variable "instance_type" {}
variable "public_web_tag_name" {}
variable "private_web_tag_name" {}


