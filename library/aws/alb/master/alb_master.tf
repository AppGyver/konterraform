resource "aws_alb" "kontena_master" {
  name            = "${var.name}-kontena-master"
  internal        = false

  security_groups = ["${aws_security_group.kontena_alb_master.id}"]
  subnets         = ["${aws_subnet.kontena_public.*.id}"]

  enable_deletion_protection = false
}

output "kontena_alb_master_dns_name" {
  value = ["${aws_alb.kontena_master.*.dns_name}"]
}
