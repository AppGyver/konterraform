resource "null_resource" "kontena_provisioner_node_first" {
  connection {
    user = "core"
    host = "${aws_instance.kontena_node.0.public_dns}"
    timeout = "30s"
  }

  provisioner "remote-exec" {
    scripts = [
      "library/support/workaround_kontena_bug_1136.sh"
    ]
  }
}
