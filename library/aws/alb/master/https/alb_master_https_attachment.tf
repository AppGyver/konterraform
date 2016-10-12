resource "aws_alb_target_group_attachment" "kontena_master_https" {
  count = "${var.kontena_master_count}"

  target_group_arn = "${aws_alb_target_group.kontena_master_https.arn}"
  target_id = "${aws_instance.kontena_master.*.id[count.index]}"

  port = 443
}
