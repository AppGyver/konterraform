resource "azurerm_public_ip" "kontena_node" {
  count = "${var.kontena_node_count}"
  name = "${var.name}-kontena-node-${count.index}"
  location = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  domain_name_label = "${var.name}-kontena-node-${count.index}"

  public_ip_address_allocation = "static"
}

output "kontena_node_public_ip_fqdn" {
  value = ["${azurerm_public_ip.kontena_node.*.fqdn}"]
}
