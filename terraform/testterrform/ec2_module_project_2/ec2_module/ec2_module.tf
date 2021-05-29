
variable "amiid" {
    type = string
    description = "This is for amazon linux ami id"
    default = "ami-0d5eff06f840b45e9"
}

variable "sg_id"{

}

resource "aws_instance" "ec2_instance" {
  ami           = var.amiid
  instance_type = "t2.nano"
  key_name = "vpc2"
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "instance_sg1"
  }
}