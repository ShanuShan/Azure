provider "aws" {
  access_key = "AKIAVGAKUL3D6XDEAGNO"
  secret_key = "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"
  region = "eu-west-1"

}

module "ec2_module"{
    source = "./ec2_module"
}