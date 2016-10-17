resource "aws_elb_attachment" "kontena_nodes_tcp" {
  count = "${var.kontena_node_count}"

  elb      = "${aws_elb.kontena_nodes_tcp.id}"
  instance = "${aws_instance.kontena_node.*.id[count.index]}"
}
