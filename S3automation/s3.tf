provider "aws" {
  alias = "us_east"
  region = "us-east-1"
}

provider "aws" {
  alias = "us-west"
  region = "us-west-2"
}

#first bucket
resource "aws_s3_bucket" "example_east" {

  provider = aws.us_east
  bucket = "sank-east-1"

}

resource "aws_s3_bucket_versioning" "versioning_example_east" {
  provider = aws.us_east
  bucket = aws_s3_bucket.example_east.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example_east" {
   provider = aws.us_east
   bucket = aws_s3_bucket.example_east.id

    rule {

      apply_server_side_encryption_by_default {

        sse_algorithm = "AES256"

      }

    }
  }

resource "aws_s3_bucket_policy" "example_east" {

 provider = aws.us_east
 bucket = aws_s3_bucket.example_east.id

  # Specify the JSON policy document from your file

  policy = file("/home/ec2-user/s3/bucket_policy_east.json")

}

#Second bucket
resource "aws_s3_bucket" "example_west" {

  provider = aws.us-west
  bucket = "sank-west-2"

}

 resource "aws_s3_bucket_versioning" "versioning_example_west" {
  provider = aws.us-west
  bucket = aws_s3_bucket.example_west.id
  versioning_configuration {
    status = "Disabled"
  }
}



resource "aws_s3_bucket_server_side_encryption_configuration" "example_west" {
  provider = aws.us-west
  bucket = aws_s3_bucket.example_west.id


    rule {

      apply_server_side_encryption_by_default {


        sse_algorithm = "AES256"

      }

    }
  }


resource "aws_s3_bucket_policy" "example_west" {
 provider = aws.us-west
 bucket = aws_s3_bucket.example_west.id

  # Specify the JSON policy document from your file

  policy = file("/home/ec2-user/s3/bucket_policy_west.json")

}
