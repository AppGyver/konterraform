resource "aws_route_table" "kontena_public" {
  vpc_id           = "${aws_vpc.kontena.id}"

  tags {
    Name = "${var.name}-kontena-public"
  }
}
