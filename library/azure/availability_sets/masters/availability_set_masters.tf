variable "azure_availability_set_masters_platform_update_domain_count" { default = "5" }
variable "azure_availability_set_masters_platform_fault_domain_count" { default = "3" }

resource "azurerm_availability_set" "kontena_masters" {
    name = "${var.name}-kontena-masters"
    resource_group_name = "${azurerm_resource_group.kontena.name}"
    location = "${var.azure_location}"

    platform_update_domain_count = "${var.azure_availability_set_masters_platform_update_domain_count}"
    platform_fault_domain_count = "${var.azure_availability_set_masters_platform_fault_domain_count}"
}
