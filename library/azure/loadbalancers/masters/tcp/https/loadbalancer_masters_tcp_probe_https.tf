resource "azurerm_lb_probe" "kontena_masters_tcp_https" {
  name = "${var.name}-kontena-masters-tcp-https"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  location = "${var.azure_location}"
  loadbalancer_id = "${azurerm_lb.kontena_masters.id}"
  protocol = "Tcp"
  port = 443
}
