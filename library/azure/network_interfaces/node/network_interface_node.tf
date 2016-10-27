resource "azurerm_network_interface" "kontena_node" {
  count = "${var.kontena_node_count}"
  name = "${var.name}-kontena-node-${count.index}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  location = "${var.azure_location}"

  network_security_group_id = "${azurerm_network_security_group.kontena_nodes.id}"

  internal_dns_name_label = "kontena-node-${count.index}"

  ip_configuration {
      name = "${var.name}-kontena-node-${count.index}"
      subnet_id = "${element(azurerm_subnet.kontena.*.id, (count.index % length(azurerm_subnet.kontena.*.id)))}"
      private_ip_address_allocation = "dynamic"

      public_ip_address_id = "${element(azurerm_public_ip.kontena_node.*.id, count.index)}"

      load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.kontena_nodes.id}"]
  }
}
