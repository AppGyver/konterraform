variable "azure_location" {}

resource "azurerm_resource_group" "kontena" {
    name     = "${var.name}-kontena"
    location = "${var.azure_location}"
}
