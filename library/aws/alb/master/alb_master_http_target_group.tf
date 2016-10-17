resource "aws_alb_target_group" "kontena_master_http" {
  # 32 char limit on name (!)
  name     = "${var.name}-kontena-m-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.kontena.id}"

  health_check = {
    interval = 10
    path = "/"
    protocol = "HTTP"
    timeout = 5

    healthy_threshold = 3
    unhealthy_threshold = 2
    matcher = "200"
  }
}
