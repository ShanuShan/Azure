provider "aws" {
  access_key = "AKIAVGAKUL3D6XDEAGNO"
  secret_key = "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"
  region = "us-east-1"

}

module "sg_module" {
  source = "./sg_module"
}

module "ec2_module" {
    sg_id = "${module.sg_module.sg_output}"
    source = "./ec2_module"
}