variable "azure_virtual_network_address_space" { default = "10.0.0.0/16" }

resource "azurerm_virtual_network" "kontena" {
    name = "${var.name}-kontena"
    address_space = ["${var.azure_virtual_network_address_space}"]
    location = "${var.azure_location}"
    resource_group_name = "${azurerm_resource_group.kontena.name}"
}
