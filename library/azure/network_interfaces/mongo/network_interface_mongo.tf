resource "azurerm_network_interface" "kontena_mongo" {
  count = "${var.kontena_mongo_count}"
  name = "${var.name}-kontena-mongo-${count.index}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  location = "${var.azure_location}"

  network_security_group_id = "${azurerm_network_security_group.kontena_mongos.id}"

  internal_dns_name_label = "${var.name}-kontena-mongo-${count.index}"

  ip_configuration {
      name = "${var.name}-kontena-mongo-${count.index}"
      subnet_id = "${element(azurerm_subnet.kontena.*.id, (count.index % length(azurerm_subnet.kontena.*.id)))}"
      private_ip_address_allocation = "dynamic"

      public_ip_address_id = "${element(azurerm_public_ip.kontena_mongo.*.id, count.index)}"
  }
}

output "kontena_mongo_internal_fqdn" {
  value = ["${azurerm_network_interface.kontena_mongo.*.internal_fqdn}"]
}
