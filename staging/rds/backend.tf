terraform {
    backend "s3" {
        bucket         = "practice-remote-states"
        key            = "staging/rds"
        region         = "us-west-2"
        encrypt        = true
    }
}