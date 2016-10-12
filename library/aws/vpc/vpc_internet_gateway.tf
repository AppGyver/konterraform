resource "aws_internet_gateway" "kontena" {
  vpc_id = "${aws_vpc.kontena.id}"

  tags {
    Name = "${var.name}-kontena"
  }
}
