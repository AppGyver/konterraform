resource "aws_instance" "kontena_mongosingle" {
  count = "${var.kontena_mongo_count}"
  disable_api_termination = "${var.aws_instance_mongosingle_disable_api_termination}"

  ami = "${lookup(var.aws_instance_ami_id_by_virtualization_type, var.aws_instance_mongosingle_virtualization_type)}"
  instance_type = "${var.aws_instance_mongosingle_type}"

  subnet_id = "${element(aws_subnet.kontena_public.*.id, (count.index % length(aws_subnet.kontena_public.*.id)))}"
  vpc_security_group_ids = ["${aws_security_group.kontena_mongos.id}"]

  associate_public_ip_address = true

  key_name = "${aws_key_pair.kontena.key_name}"

  ebs_optimized = "${var.aws_instance_mongosingle_ebs_optimized}"

  root_block_device {
    volume_type = "${var.aws_instance_mongosingle_root_block_device_volume_type}"
    volume_size = "${var.aws_instance_mongosingle_root_block_device_volume_size}"
    delete_on_termination = "${var.aws_instance_mongosingle_root_block_device_delete_on_termination}"
  }

  tags {
    Name = "${var.name}-kontena-mongosingle-${count.index}"
  }

  user_data = "${element(data.template_file.coreos_cloudconfig_mongosingle.*.rendered, count.index)}"
}

output "kontena_mongo_count" {
  value = "${var.kontena_mongo_count}"
}

output "kontena_mongo_public_dns" {
  value = ["${aws_instance.kontena_mongosingle.*.public_dns}"]
}

output "kontena_mongo_private_dns" {
  value = ["${aws_instance.kontena_mongosingle.*.private_dns}"]
}
