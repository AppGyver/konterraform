resource "aws_security_group" "kontena_elb_nodes" {
  name = "${var.name}-kontena-elb-nodes"
  tags = {
    Name = "${var.name}-kontena-elb-nodes"
  }

  vpc_id = "${aws_vpc.kontena.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
