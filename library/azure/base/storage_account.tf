resource "azurerm_storage_account" "kontena" {
    name = "${var.name}kontena"
    resource_group_name = "${azurerm_resource_group.kontena.name}"
    location = "${var.azure_location}"
    #TODO:
    account_type = "Standard_LRS"
}
