resource "aws_alb_target_group" "kontena_nodes_https" {
  # 32 char limit on name (!)
  name     = "${var.name}-kontena-n-https"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.kontena.id}"
}
