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
  vpc_id                 = "vpc-00feacb6d220c5212"
  subnets                = [ "subnet-0bb70691292e64ea7", "subnet-07ce57e703be85c3b"  ]
  environment = "prod"
}