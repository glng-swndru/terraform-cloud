module "rds_web_server" {    
    source = "../../modules/rds"
    db_name = "web_server_db"
    db_username = "sibolang"
    db_password = "password-rahasia-hehe"
    db_instance_class = "db.t2.micro"
    db_engine = "mysql"
    db_engine_version = "5.7"
    db_storage = 20
    region = "us-west-2"
    
}