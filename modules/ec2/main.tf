# Membuat VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Membuat subnet di availability zone pertama
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_a_cidr
  availability_zone = var.availability_zones[0]
}

# Membuat subnet di availability zone kedua
resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_b_cidr
  availability_zone = var.availability_zones[1]
}


# Membuat Internet Gateway dan attach ke VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.cluster_name}-${var.environment}-igw"
  }
}

# Membuat Route Table untuk Internet Gateway
resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.cluster_name}-${var.environment}-rtb"
  }
}

# Mengasosiasikan route table ke subnet
resource "aws_route_table_association" "subnet_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.internet.id
}

resource "aws_route_table_association" "subnet_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.internet.id
}

# Security Group untuk Web Service
resource "aws_security_group" "web_service" {
  name = "${var.cluster_name}-${var.environment}-alb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Load Balancer untuk Web Service
resource "aws_lb" "web_service" {
  name               = "${var.cluster_name}-${var.environment}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_service.id]
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}

# Target Group untuk Load Balancer
resource "aws_lb_target_group" "web_service" {
  name     = "${var.cluster_name}-${var.environment}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Listener untuk Load Balancer
resource "aws_lb_listener" "web_service" {
  load_balancer_arn = aws_lb.web_service.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_service.arn
  }
}

# Launch Configuration untuk EC2 Instances
resource "aws_launch_configuration" "example" {
  name                      = "${var.cluster_name}-${var.environment}"
  image_id                  = var.ami
  instance_type             = var.instance_type
  key_name                  = var.key_pair
  security_groups           = [aws_security_group.web_service.id]
  associate_public_ip_address = true

  user_data = <<-EOF
                #!/bin/bash
                apt-get update -y
                apt-get install -y python3
                echo "Hello, World!" > index.html
                nohup python3 -m http.server 80 &
                EOF

  lifecycle {
    create_before_destroy = false
  }
}

# Auto Scaling Group untuk EC2 Instances
resource "aws_autoscaling_group" "web_service" {
  launch_configuration = aws_launch_configuration.example.id
  target_group_arns    = [aws_lb_target_group.web_service.arn]
  min_size             = var.instance_min_count
  max_size             = var.instance_max_count
  health_check_type    = "ELB"

  availability_zones   = var.asg_availability_zones
  vpc_zone_identifier  = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  
  tag {
    key                 = "Name"
    value               = "web-instance-${var.environment}"
    propagate_at_launch = true
  }
}
