resource "azurerm_lb_backend_address_pool" "kontena_nodes" {
  name = "${var.name}-kontena-nodes"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  location = "${var.azure_location}"
  loadbalancer_id = "${azurerm_lb.kontena_nodes.id}"
}
