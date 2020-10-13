provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

module "aws_ec2" {
  source = "./EC2"
 }

module "aws_rds" {
  source = "./RDS"
 }




