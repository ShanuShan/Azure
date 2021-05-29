variable "vpcid" {
    type = string
    description = "default vpc id"
    default = "vpc-ef868387"
}

variable "amiid" {
    type = string
    description = "This is for amazon linux ami id"
    default = "ami-010aff33ed5991201"
}
resource "aws_security_group" "ec2_securitygroup" {
  name        = "ssh_security_module"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpcid

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = var.amiid
  instance_type = "t2.nano"
  key_name = "linux"
  vpc_security_group_ids = ["${aws_security_group.ec2_securitygroup.id}"]

  tags = {
    Name = "HelloWorld"
  }
}