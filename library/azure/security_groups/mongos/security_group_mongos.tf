resource "azurerm_network_security_group" "kontena_mongos" {
  name = "${var.name}-kontena-mongos"
  location = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"

  security_rule {
      name = "${var.name}-ssh"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "22"
      source_address_prefix = "*"
      destination_address_prefix = "*"
      access = "Allow"
      priority = 100
      direction = "Inbound"
  }
}
