resource "aws_alb_listener" "kontena_nodes_https" {
   load_balancer_arn = "${aws_alb.kontena_nodes.arn}"
   port = 443
   protocol = "HTTPS"

   default_action {
     target_group_arn = "${aws_alb_target_group.kontena_nodes_https.arn}"
     type = "forward"
   }
}
