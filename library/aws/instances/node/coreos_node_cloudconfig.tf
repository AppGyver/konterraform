variable "coreos_node_locksmith_window_start" { default = "Tue 08:00" }
variable "coreos_node_locksmith_window_length" { default = "1h" }
variable "coreos_node_update_reboot_strategy" { default = "etcd-lock" }

variable "coreos_node_hostname_midfix" { default = "node" }
variable "coreos_node_dns_server" { default = "10.0.0.2" }

data "template_file" "coreos_cloudconfig_node" {
  count = "${var.kontena_node_count}"

  template = "${file("library/coreos/node/coreos_node_cloudconfig.yml")}"

  vars {
    hostname = "${var.name}-${var.coreos_node_hostname_midfix}-${count.index}"
    dns_server = "${var.coreos_node_dns_server}"

    docker_label_region = "${var.name}-${var.aws_region}"
    docker_label_az = "${element(data.aws_availability_zones.available.names, (count.index % var.kontena_node_count))}"
    docker_label_instance_type = "${var.aws_instance_node_type}"

    coreos_locksmith_window_start = "${var.coreos_node_locksmith_window_start}"
    coreos_locksmith_window_length = "${var.coreos_node_locksmith_window_length}"
    coreos_update_reboot_strategy = "${var.coreos_node_update_reboot_strategy}"

    version = "${var.kontena_agent_version}"
    peer_interface = "${var.kontena_agent_peer_interface}"
    master_uri = "${var.kontena_agent_master_uri}"
    token = "${var.kontena_agent_token}"
    agent_memory_limit = "${var.kontena_agent_memory_limit}"

    kontena_agent_image = "${var.kontena_agent_image}"
    kontena_agent_version = "${var.kontena_agent_version}"
  }
}
