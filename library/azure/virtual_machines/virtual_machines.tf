variable "ssh_public_key_file" { default = "~/.ssh/id_rsa.pub" }

variable "azure_virtual_machine_mongosingle_vm_size" { default = "Standard_D2_v2" }
variable "azure_virtual_machine_mongosingle_delete_os_disk_on_termination" { default = true }
variable "azure_virtual_machine_mongosingle_boot_diagnostics_enabled" { default = false }

variable "azure_virtual_machine_master_vm_size" { default = "Standard_D2_v2" }
variable "azure_virtual_machine_master_delete_os_disk_on_termination" { default = true }
variable "azure_virtual_machine_master_boot_diagnostics_enabled" { default = false }

variable "azure_virtual_machine_mastermongo_vm_size" { default = "Standard_D2_v2" }
variable "azure_virtual_machine_mastermongo_delete_os_disk_on_termination" { default = true }
variable "azure_virtual_machine_mastermongo_boot_diagnostics_enabled" { default = false }

variable "azure_virtual_machine_node_vm_size" { default = "Standard_D2_v2" }
variable "azure_virtual_machine_node_delete_os_disk_on_termination" { default = true }
variable "azure_virtual_machine_node_boot_diagnostics_enabled" { default = false }

resource "random_id" "kontena_password" {
  byte_length = 16
}
