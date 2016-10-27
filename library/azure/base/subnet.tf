resource "azurerm_subnet" "kontena" {
  count = 3
  name = "${var.name}-kontena-${count.index}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  virtual_network_name = "${azurerm_virtual_network.kontena.name}"

  address_prefix = "10.0.${count.index}.0/24"
}
