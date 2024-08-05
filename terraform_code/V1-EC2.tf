provider "aws" {
    region = "ap-south-1"
}

# Ensure a default VPC exists
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Get the default subnet IDs
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

# Use the first subnet from the default VPC
data "aws_subnet" "default" {
  id = data.aws_subnets.default.ids[0]
}


resource "aws_instance" "demo-server" {
    ami = "ami-025fe52e1f2dc5044"
    instance_type = "t2.micro"
    key_name = "DevopsProject_1"
    # Use the default subnet
    subnet_id = data.aws_subnet.default.id

}