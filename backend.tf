terraform {
  backend "s3" {
    # Bucket S3
    bucket = "maurial-terraform-state"
    key    = "network.ftstate"
    region = "us-east-1"
    # DynamoDB Table, Partition Key = LockID
    dynamodb_table = "maurial-terraform-state"
  }
}
