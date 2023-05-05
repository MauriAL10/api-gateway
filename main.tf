provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source           = "./vpc"
  cidr_block       = "10.0.0.0/16"
  vpc_name         = "my-vpc"
  subnet_cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  subnet_name       = "public-us-east-1a"
  igw_name          = "main-igw"
  route_table_name  = "public"
}

module "ec2" {
  source          = "./ec2-instance"
  ami_id          = "ami-083602cee93914c0c"
  instance_type   = "t2.micro"
  key_name        = "MauriKeyPair2"
  subnet_id       = module.vpc.subnet_id
  vpc_id          = module.vpc.vpc_id
  instance_name   = "my-app-example-1"
}

module "api_gateway" {
  source               = "./api-gateway"
  api_name             = "api-gw-example-1"
  instance_public_ip   = module.ec2.public_ip
}

output "api_pf_url" {
  value = module.api_gateway.api_pf_url
}