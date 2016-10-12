resource "aws_route" "kontena_internet_gateway" {
  route_table_id         = "${aws_route_table.kontena_public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kontena.id}"
}
