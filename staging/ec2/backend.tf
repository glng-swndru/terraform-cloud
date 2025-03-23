terraform {
    backend "s3" {
        bucket         = "practice-remote-states"
        key            = "staging/ec2"
        region         = "us-west-2"
        encrypt        = true
    }
}