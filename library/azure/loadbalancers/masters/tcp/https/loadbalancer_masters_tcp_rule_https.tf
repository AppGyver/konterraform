resource "azurerm_lb_rule" "kontena_masters_tcp_https" {
  name = "${var.name}-kontena-masters-tcp-https"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  location = "${var.azure_location}"
  loadbalancer_id = "${azurerm_lb.kontena_masters.id}"
  frontend_ip_configuration_name = "${var.name}-kontena-masters"

  protocol = "Tcp"
  frontend_port = 443
  backend_port = 443
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.kontena_masters.id}"
  probe_id = "${azurerm_lb_probe.kontena_masters_tcp_http.id}"
}
