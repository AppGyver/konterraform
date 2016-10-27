resource "azurerm_lb" "kontena_masters" {
    name = "${var.name}-kontena-masters"
    resource_group_name = "${azurerm_resource_group.kontena.name}"
    location = "${var.azure_location}"

    frontend_ip_configuration {
      name = "${var.name}-kontena-masters"
      public_ip_address_id = "${azurerm_public_ip.kontena_loadbalancer_masters.id}"
    }
}
