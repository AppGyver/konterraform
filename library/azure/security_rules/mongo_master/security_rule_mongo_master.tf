resource "azurerm_network_security_rule" "kontena_mongos_master" {
  count = "${var.kontena_master_count}"

  name = "${var.name}-kontena-mongos-master"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  network_security_group_name = "${azurerm_network_security_group.kontena_mongos.name}"

  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "*"
  source_address_prefix = "${element(azurerm_public_ip.kontena_master.*.ip_address, count.index)}"
  destination_address_prefix = "*"
  access = "Allow"
  priority = "20${count.index}"

  direction = "Inbound"
}
