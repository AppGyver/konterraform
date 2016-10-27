resource "azurerm_public_ip" "kontena_mongo" {
  count = "${var.kontena_mongo_count}"
  name = "${var.name}-kontena-mongo-${count.index}"
  location = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.kontena.name}"
  domain_name_label = "${var.name}-kontena-mongo-${count.index}"

  public_ip_address_allocation = "static"
}

output "kontena_mongo_public_ip_fqdn" {
  value = ["${azurerm_public_ip.kontena_mongo.*.fqdn}"]
}
