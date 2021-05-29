variable "vpcid" {
    type = string
    description = "default vpc id"
    default = "vpc-fb6a2681"
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

output "sg_output" {
    value = "${aws_security_group.ec2_securitygroup.id}"
}
