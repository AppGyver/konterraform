resource "null_resource" "kontena_provisioner_mongo_replica_set_initializer" {
  connection {
    user = "core"
    host = "${azurerm_public_ip.kontena_mongo.0.ip_address}"
    timeout = "30s"
  }

  provisioner "file" {
      source = "library/support/mongo_replica_set_initializer.sh"
      destination = "/tmp/mongo_replica_set_initializer.sh"
  }

  provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/mongo_replica_set_initializer.sh",
        "/tmp/mongo_replica_set_initializer.sh"
      ]
  }
}
