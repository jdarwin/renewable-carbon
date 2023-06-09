resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

resource "aws_route_table_association" "route_table_association_a" {
    subnet_id      = aws_subnet.pub_subnet1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "route_table_association_b" {
    subnet_id      = aws_subnet.pub_subnet2.id
    route_table_id = aws_route_table.public.id
}