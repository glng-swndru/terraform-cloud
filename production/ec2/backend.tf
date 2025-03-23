terraform {
    backend "s3" {
        bucket         = "practice-remote-state-123"
        key            = "production/ec2"
        region         = "us-west-2"
        encrypt        = true
    }
}