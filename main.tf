# Root main.tf WO 14th September
# New

provider "aws" {
  region = "ap-southeast-1"
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = "my-app-table"
}

module "iam" {
  source        = "./modules/iam"
  name_prefix   = "app"
  dynamodb_arn  = module.dynamodb.table_arn
  actions       = [
    "dynamodb:GetItem",
    "dynamodb:PutItem",
    "dynamodb:UpdateItem",
    "dynamodb:Scan",
    "dynamodb:Query"
  ]
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = "ami-0be9cb9f67c8dabd6"
  instance_type     = "t3.micro"
  instance_profile  = module.iam.instance_profile_name
  name              = "app-server"

  subnet_id         = data.aws_subnet.default.id
  security_group_ids = []
}

data "aws_subnet" "default" {
  filter {
    name   = "tag:Name"
    values = ["shared-vpc-public-ap-southeast-1c"]
  }
}






