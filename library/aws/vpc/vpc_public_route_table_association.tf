resource "aws_route_table_association" "kontena_public" {
  count          = "${length(var.aws_public_subnet_cidr_blocks)}"

  subnet_id      = "${element(aws_subnet.kontena_public.*.id, count.index)}"
  route_table_id = "${aws_route_table.kontena_public.id}"
}
