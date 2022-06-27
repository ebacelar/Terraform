terraform{
  required_version = ">= 0.12.24"

  backend "s3" {
    bucket = "dboullon-test-344791879147-us-west-2"
    key = "cloudgithubactiontf.tfstate"
    region = "us-west-2"
  }
}
provider "aws" {
  region = "us-west-2"
  #profile = "terraform-user"
}
