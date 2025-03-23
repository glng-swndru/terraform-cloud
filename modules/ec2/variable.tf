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