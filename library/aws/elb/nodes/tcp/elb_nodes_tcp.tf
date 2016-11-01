resource "aws_elb" "kontena_nodes_tcp" {
  // 32 char limit..
  name = "${var.name}-k-n-tcp"

  tags {
    Name = "${var.name}-k-n-tcp"
  }

  security_groups = ["${aws_security_group.kontena_elb_nodes.id}"]
  subnets         = ["${aws_subnet.kontena_public.*.id}"]
  internal = false

  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }

  listener {
    instance_port = 443
    instance_protocol = "tcp"
    lb_port = 443
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "TCP:80"
    interval = 15
  }

  cross_zone_load_balancing = true
  idle_timeout = 60

  connection_draining = true
  connection_draining_timeout = 15
}


output "kontena_elb_nodes_tcp_dns_name" {
  value = ["${aws_elb.kontena_nodes_tcp.*.dns_name}"]
}
