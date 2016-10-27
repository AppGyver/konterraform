resource "azurerm_public_ip" "kontena_loadbalancer_masters" {
  name = "${var.name}-kontena-loadbalancer-masters"
  location = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  domain_name_label = "${var.name}-kontena-lb-masters"

  public_ip_address_allocation = "static"
}

output "kontena_loadbalancer_masters_public_ip_fqdn" {
  value = ["${azurerm_public_ip.kontena_loadbalancer_masters.*.fqdn}"]
}
