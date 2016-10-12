resource "aws_alb" "kontena_nodes" {
  name            = "${var.name}-kontena-nodes"
  internal        = false

  security_groups = ["${aws_security_group.kontena_alb_nodes.id}"]
  subnets         = ["${aws_subnet.kontena_public.*.id}"]

  enable_deletion_protection = false
}

output "kontena_alb_nodes_dns_name" {
  value = ["${aws_alb.kontena_nodes.*.dns_name}"]
}
