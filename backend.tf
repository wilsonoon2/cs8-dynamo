terraform {
    backend "s3" {
        bucket = "wo-sctps3bucket"
        key    = "cs-8-dynamo/terraform.tfstate"
        region = "ap-southeast-1"
    }
}
