resource "aws_alb_listener" "kontena_master_https" {
   load_balancer_arn = "${aws_alb.kontena_master.arn}"
   port = 443
   protocol = "HTTPS"

   ssl_policy = "ELBSecurityPolicy-2015-05"
   certificate_arn = "${aws_iam_server_certificate.kontena_master.arn}"

   default_action {
     target_group_arn = "${aws_alb_target_group.kontena_master_http.arn}"
     type = "forward"
   }
}
