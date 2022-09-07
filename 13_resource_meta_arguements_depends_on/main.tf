#depends-on means it will create s3 create first and next ec2-instance will create.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.58.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "43802482094298-depends-on"
}

resource "aws_instance" "my_server" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
	depends_on = [
		aws_s3_bucket.bucket  #depends-on means it will create s3 create first and next ec2-instance will create.
	]
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}
########command for creating##
# terraform init 
# terraform plan 
# terraform apply
# terraform apply --auto-approve
# terraform destroy --auto-approve
