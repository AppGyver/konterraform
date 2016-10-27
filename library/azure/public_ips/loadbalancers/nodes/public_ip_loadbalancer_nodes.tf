resource "azurerm_public_ip" "kontena_loadbalancer_nodes" {
  name = "${var.name}-kontena-loadbalancer-nodes"
  location = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  domain_name_label = "${var.name}-kontena-lb-nodes"

  public_ip_address_allocation = "static"
}

output "kontena_loadbalancer_nodes_public_ip_fqdn" {
  value = ["${azurerm_public_ip.kontena_loadbalancer_nodes.*.fqdn}"]
}
