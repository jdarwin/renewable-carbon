provider "aws" {
    region = "eu-central-1"
}

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags       = {
        Name = "RenewableCarbon VPC"
    }
}