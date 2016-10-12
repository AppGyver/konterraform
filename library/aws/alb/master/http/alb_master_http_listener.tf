resource "aws_alb_listener" "kontena_master_http" {
   load_balancer_arn = "${aws_alb.kontena_master.arn}"
   port = 80
   protocol = "HTTP"

   default_action {
     target_group_arn = "${aws_alb_target_group.kontena_master_http.arn}"
     type = "forward"
   }
}
