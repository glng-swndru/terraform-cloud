variable "region" {
    description = "The region to deploy resources into"
    type        = string
    default     = "us-west-2"
}

variable "db_name" {
    description = "The name of the database"
    type        = string
}   

variable "db_username" {
    description = "The username of the database"
    type        = string
  
}

variable "db_password" {
    description = "The password of the database"
    type        = string
  
}

variable "db_instance_class" {
    description = "The instance class of the database"
    type        = string

}

variable "db_engine" {
    description = "The engine of the database"
    type        = string
  
}

variable "db_engine_version" {
    description = "The engine version of the database"
    type        = string    
  
}

variable "db_storage" {
    description = "The storage of the database"
    type        = number
}
