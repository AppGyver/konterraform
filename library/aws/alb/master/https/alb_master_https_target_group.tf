resource "aws_alb_target_group" "kontena_master_https" {
  # 32 char limit on name (!)
  name     = "${var.name}-kontena-m-https"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.kontena.id}"

  health_check = {
    interval = 10
    path = "/"
    protocol = "HTTPS"
    timeout = 5

    healthy_threshold = 3
    unhealthy_threshold = 2
    matcher = "200"
  }
}
