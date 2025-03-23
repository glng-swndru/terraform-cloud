module "web-server-prod" {
  source = "../../modules/ec2"
  
  ami                    = "ami-0520f976ad2e6300c"
  instance_type          = "t2.micro"
  tag_name               = "web-server"
  instance_min_count     = 2
  instance_max_count     = 3
  cluster_name           = "web-server"
  key_pair               = "terraform-key-pair"
  asg_availability_zones = ["us-west-2a", "us-west-2b"]
  elb_availability_zones = ["us-west-2a", "us-west-2b"]
 vpc_id                  = "vpc-0ae9320d2378da536"
  subnets                = [ "subnet-0bde42ef0439aa554", "subnet-0e00f52c5201d9209"  ]
  environment = "prod"
}