module "web-server-prod" {
  source = "../../modules/ec2"
  
  ami                    = "ami-0520f976ad2e6300c"
  instance_type          = "t2.micro"
  tag_name               = "web-server"
  instance_min_count     = 4
  instance_max_count     = 5
  cluster_name           = "web-server"
  key_pair               = "terraform-key-pair"
  asg_availability_zones = ["us-west-2a", "us-west-2b"]
  elb_availability_zones = ["us-west-2a", "us-west-2b"]
  vpc_id                 = aws_vpc.main.id  # Menggunakan vpc_id yang terbuat di modul
  subnets                = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]  # Menggunakan subnet yang terbuat di modul
  environment            = "prod"
}
