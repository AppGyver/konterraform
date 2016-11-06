resource "azurerm_virtual_machine" "kontena_mongo" {
  count = "${var.kontena_mongo_count}"

  name                  = "${var.name}-kontena-mongo-${count.index}"
  resource_group_name   = "${azurerm_resource_group.kontena.name}"
  location              = "${var.azure_location}"
  availability_set_id   = "${azurerm_availability_set.kontena_mongo.id}"

  boot_diagnostics = {
    enabled = "${var.azure_virtual_machine_mongo_boot_diagnostics_enabled}"
    storage_uri = "${azurerm_storage_account.kontena.primary_blob_endpoint}"
  }

  vm_size               = "${var.azure_virtual_machine_mongo_vm_size}"

  storage_image_reference {
    publisher = "CoreOS"
    offer     = "CoreOS"
    sku       = "Stable"
    version   = "latest"
  }

  storage_os_disk {
    name          = "kontena-mongo-${count.index}"
    vhd_uri       = "${azurerm_storage_account.kontena.primary_blob_endpoint}${azurerm_storage_container.kontena.name}/kontena-mongo-${count.index}.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  delete_os_disk_on_termination = "${var.azure_virtual_machine_mongo_delete_os_disk_on_termination}"

  os_profile {
    computer_name  = "${var.name}-kontena-mongo-${count.index}"
    admin_username = "core"
    admin_password = "ThisShouldBeDisabledButIsRequired${count.index}${random_id.kontena_password.hex}"

    custom_data = "${base64encode(element(data.template_file.coreos_cloudconfig_mongo.*.rendered, count.index))}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys = {
      path = "/home/core/.ssh/authorized_keys"
      key_data = "${file(var.ssh_public_key_file)}"
    }
  }

  network_interface_ids = ["${element(azurerm_network_interface.kontena_mongo.*.id, count.index)}"]
}
