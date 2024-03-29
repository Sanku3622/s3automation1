variable "bucket_prefix" {

  default = "sankethcl1234"

}

# Create S3 buckets in us-east-1

provider "aws" {

  alias  = "us-east-1"

  region = "us-east-1"

}


# Create S3 buckets in us-west-1

provider "aws" {

  alias  = "us-west-1"

  region = "us-west-1"

}



# Create 25 S3 buckets in us-east-1

 resource "aws_s3_bucket" "sankethcl1234_us_east_1" {

  count         = 2

  provider      = aws.us-east-1

  bucket        = "${var.bucket_prefix}-us-east-1-${count.index + 1}"

  acl           = "private"

 # force_destroy = true

  # Add more bucket configurations as needed

}

# Create 25 S3 buckets in us-west-1

resource "aws_s3_bucket" "sankethcl1234_us_west_1" {

  count         = 2

  provider      = aws.us-west-1

  bucket        = "${var.bucket_prefix}-us-west-1-${count.index + 1}"

  acl           = "private"

#  force_destroy = true

  # Add more bucket configurations as needed

}
