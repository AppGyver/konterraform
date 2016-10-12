variable "aws_public_subnet_count" { default = 3 }

variable "aws_public_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

resource "aws_subnet" "kontena_public" {
  count = "${var.aws_public_subnet_count}"

  vpc_id = "${aws_vpc.kontena.id}"
  cidr_block = "${var.aws_public_subnet_cidr_blocks[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "${var.name}-kontena-public-subnet-az-${count.index}"
  }
}
