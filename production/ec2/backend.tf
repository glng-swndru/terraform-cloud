terraform {
    backend "s3" {
        bucket         = "practice-remote-states"
        key            = "production/ec2"
        region         = "us-west-2"
        encrypt        = true
    }
}