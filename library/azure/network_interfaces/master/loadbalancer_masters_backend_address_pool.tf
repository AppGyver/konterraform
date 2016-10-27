resource "azurerm_lb_backend_address_pool" "kontena_masters" {
  name = "${var.name}-kontena-masters"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  location = "${var.azure_location}"
  loadbalancer_id = "${azurerm_lb.kontena_masters.id}"
}
