resource "azurerm_network_security_group" "kontena_nodes" {
  name = "${var.name}-kontena-nodes"
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

  security_rule {
      name = "${var.name}-http"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "80"
      source_address_prefix = "*"
      destination_address_prefix = "*"

      access = "Allow"
      priority = 200
      direction = "Inbound"
  }

  security_rule {
      name = "${var.name}-https"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = "443"
      source_address_prefix = "*"
      destination_address_prefix = "*"

      access = "Allow"
      priority = 300
      direction = "Inbound"
  }
}
