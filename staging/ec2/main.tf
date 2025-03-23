module "web-server-prod" {
  source = "../../modules/ec2"

  ami                    = "ami-0520f976ad2e6300c"
  instance_type          = "t2.micro"
  tag_name               = "web-server"
  instance_min_count     = 2
  instance_max_count     = 3
  cluster_name           = "web-server-gold"
  key_pair               = "terraform-key-pair"
  asg_availability_zones = ["us-west-2a", "us-west-2b"]
  elb_availability_zones = ["us-west-2a", "us-west-2b"]
  vpc_id                 = aws_vpc.main.id # VPC ID
  subnets                = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id] # Subnet IDs
  environment            = "staging"
}
