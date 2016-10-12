resource "aws_alb_listener" "kontena_master_https" {
   load_balancer_arn = "${aws_alb.kontena_master.arn}"
   port = 443
   protocol = "HTTPS"

   default_action {
     target_group_arn = "${aws_alb_target_group.kontena_master_https.arn}"
     type = "forward"
   }
}
