resource "azurerm_storage_container" "kontena" {
    name = "${var.name}-kontena"
    resource_group_name = "${azurerm_resource_group.kontena.name}"
    storage_account_name = "${azurerm_storage_account.kontena.name}"

    #TODO:
    container_access_type = "private"
}
