resource "azurerm_public_ip" "kontena_master" {
  count = "${var.kontena_master_count}"
  name = "${var.name}-kontena-master-${count.index}"
  location = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  domain_name_label = "${var.name}-kontena-master-${count.index}"

  public_ip_address_allocation = "static"
}

output "kontena_master_public_ip_fqdn" {
  value = ["${azurerm_public_ip.kontena_master.*.fqdn}"]
}
