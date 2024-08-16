provider "aws" {
  region = "us-east-1"
  backend "s3" {
    bucket         	   = "lab-demo-state"
    key              	   = "state/terraform.tfstate"
    encrypt        	   = true
  }

}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "mysubnet"
  }
}

resource "aws_instance" "ubuntu2204" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mysubnet.id
  tags = {
    Name = "ubuntu2204"
  }
}
