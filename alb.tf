resource "aws_alb" "application_load_balancer" {
  name               = "RenewableCarbon-alb"
  internal           = false
  load_balancer_type = "application"
  #subnets            = aws_subnet.public.*.id
  subnets            = [
    aws_subnet.pub_subnet1.id,
    aws_subnet.pub_subnet2.id
  ]
  security_groups    = [aws_security_group.load_balancer_security_group.id]

  tags = {
    Name        = "RenewableCarbon-alb"
    Environment = "Prod"
  }
}
# security groups for ALB
resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "alb-sg"
    Environment = "Prod"
  }
}
# target group for application load balancer target group, it will relate the ALB with containers
resource "aws_lb_target_group" "target_group" {
  name        = "RenewableCarbon-alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/v1/status"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "RenewableCarbon-lb-tg"
    Environment = "Prod"
  }
}
# create HTTP listener for load balancer
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }
}