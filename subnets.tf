resource "aws_subnet" "pub_subnet1" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.1.0.0/22"
    availability_zone = "eu-central-1a"    
    tags = {
        Name = "subnet-1a"
    }

}
resource "aws_subnet" "pub_subnet2" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.2.0.0/22"
    availability_zone = "eu-central-1b"
    tags = {
        Name = "subnet-1b"
    }
}