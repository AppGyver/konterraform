resource "null_resource" "kontena_provisioner_node_first" {
  connection {
    user = "core"
    host = "${azurerm_public_ip.kontena_node.0.ip_address}"
    timeout = "30s"
  }

  provisioner "remote-exec" {
    scripts = [
      "library/support/workaround_kontena_bug_1136.sh"
    ]
  }
}
