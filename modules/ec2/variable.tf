variable "ami" {
  description = "The AMI to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
}

variable "tag_name" {
  description = "The tag name for the instances"
  type        = string
}

variable "instance_min_count" {
  description = "Number of instances to create"
  type        = number
}

variable "instance_max_count" {
  description = "Number of instances to create"
  type        = number
  
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
  
}

variable "asg_availability_zones" {
    description = "The availability zones to deploy the instances"
    type        = list(string)
}

variable "elb_availability_zones" {
    description = "The availability zones to deploy the instances"
    type        = list(string)
  
}

variable "vpc_id" {
    description = "The VPC ID to deploy the instances"
    type        = string
  
}

variable "subnets" {
    description = "The subnets to deploy the instances"
    type        = list(string)
  
}

variable "key_pair" {
    description = "The key pair to use for the instances"
    type        = string
  
}


variable "environment" {
    description = "The environment to deploy the instances"
    type        = string
  
}

# CIDR blok untuk VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# CIDR blok untuk subnet A
variable "subnet_a_cidr" {
  description = "CIDR block for subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

# CIDR blok untuk subnet B
variable "subnet_b_cidr" {
  description = "CIDR block for subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

# Availability Zones untuk VPC
variable "availability_zones" {
  description = "List of availability zones to deploy the VPC and subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}
