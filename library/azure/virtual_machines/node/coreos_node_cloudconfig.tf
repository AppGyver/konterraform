variable "coreos_node_locksmith_window_start" { default = "Tue 08:00" }
variable "coreos_node_locksmith_window_length" { default = "1h" }
variable "coreos_node_update_reboot_strategy" { default = "reboot" }

variable "coreos_node_hostname_midfix" { default = "node" }
variable "coreos_node_dns_server" { default = "8.8.4.4" }

data "template_file" "coreos_cloudconfig_node" {
  count = "${var.kontena_node_count}"

  template = "${file("library/coreos/node/coreos_node_cloudconfig.yml")}"

  vars {
    hostname = "${var.name}-${var.coreos_node_hostname_midfix}-${count.index}"
    dns_server = "${var.coreos_node_dns_server}"

    docker_label_region = "${var.name}-${replace(var.azure_location, " ", "_")}"
    docker_label_az = "${count.index % var.azure_availability_set_nodes_platform_fault_domain_count}"
    docker_label_instance_type = "${var.azure_virtual_machine_node_vm_size}"

    coreos_locksmith_window_start = "${var.coreos_node_locksmith_window_start}"
    coreos_locksmith_window_length = "${var.coreos_node_locksmith_window_length}"
    coreos_update_reboot_strategy = "${var.coreos_node_update_reboot_strategy}"

    kontena_agent_image = "${var.kontena_agent_image}"
    kontena_agent_version = "${var.kontena_agent_version}"

    kontena_agent_peer_interface = "${var.kontena_agent_peer_interface}"
    kontena_agent_master_uri = "${var.kontena_agent_master_uri}"
    kontena_agent_token = "${var.kontena_agent_token}"
    kontena_agent_memory_limit = "${var.kontena_agent_memory_limit}"

  }
}
