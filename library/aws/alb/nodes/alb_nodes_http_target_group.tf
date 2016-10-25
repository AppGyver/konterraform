resource "aws_alb_target_group" "kontena_nodes_http" {
  # 32 char limit on name (!)
  name     = "${var.name}-k-n-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.kontena.id}"
}
