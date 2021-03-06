#implementing provider "aws" {
  region = "us-west-2"
}

resource "aws_dynamodb_table" "dynamo_db_table" {
  hash_key = "UserId"
  range_key = "GameTitle"

  billing_mode = "provisioned"
  name     = "GameScores"
  read_capacity = 10
  write_capacity = 10

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExists"
    enabled = false
  }

  global_secondary_index {
    hash_key        = "GameTitle"
    name            = "GameTitleIndex"
    projection_type = "INCLUDE"
    range_key = "TopScore"
    read_capacity = 10
    write_capacity = 10
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name="GameScores"
    Type="Game"
  }
}

