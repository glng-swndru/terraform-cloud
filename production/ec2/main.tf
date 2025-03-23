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
  
  # Referencing VPC and subnets from ec2 module
  vpc_id                 = module.web-server-prod.vpc_id
  subnets                = [module.web-server-prod.subnet_a_id, module.web-server-prod.subnet_b_id]
  environment            = "prod"
}
