variable "aws_vpc_cidr_block" { default = "10.0.0.0/16" }
variable "aws_vpc_enable_dns_support" { default = true }
variable "aws_vpc_enable_dns_hostnames" { default = true }

resource "aws_vpc" "kontena" {
  cidr_block = "${var.aws_vpc_cidr_block}"

  enable_dns_support = "${var.aws_vpc_enable_dns_support}"
  enable_dns_hostnames = "${var.aws_vpc_enable_dns_hostnames}"

  tags {
      Name = "${var.name}-kontena"
  }
}
