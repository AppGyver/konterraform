resource "aws_instance" "kontena_node" {
  count = "${var.kontena_node_count}"
  disable_api_termination = "${var.aws_instance_node_disable_api_termination}"

  ami = "${lookup(var.aws_instance_ami_id_by_virtualization_type, var.aws_instance_node_virtualization_type)}"
  instance_type = "${var.aws_instance_node_type}"

  subnet_id = "${element(aws_subnet.kontena_public.*.id, (count.index % length(aws_subnet.kontena_public.*.id)))}"
  vpc_security_group_ids = ["${aws_security_group.kontena_nodes.id}"]

  associate_public_ip_address = true

  key_name = "${aws_key_pair.kontena.key_name}"

  ebs_optimized = "${var.aws_instance_node_ebs_optimized}"

  root_block_device {
    volume_type = "${var.aws_instance_node_root_block_device_volume_type}"
    volume_size = "${var.aws_instance_node_root_block_device_volume_size}"
    delete_on_termination = "${var.aws_instance_node_root_block_device_delete_on_termination}"
  }

  tags {
    Name = "${var.name}-kontena-node-${count.index}"
  }

  user_data = "${element(data.template_file.coreos_cloudconfig_node.*.rendered, count.index)}"
}

output "kontena_node_public_dns" {
  value = ["${aws_instance.kontena_node.*.public_dns}"]
}
