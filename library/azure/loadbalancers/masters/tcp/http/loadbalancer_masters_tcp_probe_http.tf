resource "azurerm_lb_probe" "kontena_masters_tcp_http" {
  name = "${var.name}-kontena-masters-tcp-http"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  location = "${var.azure_location}"
  loadbalancer_id = "${azurerm_lb.kontena_masters.id}"
  protocol = "Tcp"
  port = 80
}
