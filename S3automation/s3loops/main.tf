provider "aws" {

  alias = "us_east"
  region = "us-east-1"
}

provider "aws" {

  alias = "us-west"
  region = "us-west-2"

}

provider "aws" {

  alias = "eu-west-1"
  region = "eu-west-1"

}

variable "regions" {

  type    = list(string)

  default = ["us-east-1", "us-west-2", "eu-west-1"]

}


resource "aws_s3_bucket" "example" {

  for_each = toset(var.regions)



  bucket = "sank-bucket-${each.value}"

  acl    = "private"



  # You can add other bucket configurations here

}
