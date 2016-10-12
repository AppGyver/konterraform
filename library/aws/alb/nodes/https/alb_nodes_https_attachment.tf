resource "aws_alb_target_group_attachment" "kontena_nodes_https" {
  count = "${var.kontena_node_count}"

  target_group_arn = "${aws_alb_target_group.kontena_nodes_https.arn}"
  target_id = "${aws_instance.kontena_node.*.id[count.index]}"

  port = 80
}
