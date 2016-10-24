variable "coreos_mastermongo_locksmith_window_start_prefix" { default = "Tue 08:0" }
variable "coreos_mastermongo_locksmith_window_length" { default = "1h" }
variable "coreos_mastermongo_update_reboot_strategy" { default = "reboot" }

data "template_file" "coreos_cloudconfig_mastermongo" {
  count = "${var.kontena_master_count}"

  template = "${file("library/coreos/mastermongo/coreos_mastermongo_cloudconfig.yml")}"

  vars {
    coreos_locksmith_window_start = "${var.coreos_mastermongo_locksmith_window_start_prefix}${count.index * 3 % 60}"
    coreos_locksmith_window_length = "${var.coreos_mastermongo_locksmith_window_length}"
    coreos_update_reboot_strategy = "${var.coreos_mastermongo_update_reboot_strategy}"

    mongodb_uri = "mongodb://kontena-server-mongo:27017/${var.name}_master"
    version = "${var.kontena_master_version}"
    vault_iv = "${var.kontena_master_vault_iv}"
    vault_key = "${var.kontena_master_vault_key}"
    max_threads = "${var.kontena_master_max_threads}"
    web_concurrency = "${var.kontena_master_web_concurrency}"

    mongo_version = "${var.mongo_version}"
    bind_ip = "${var.mongo_bind_ip}"
  }
}
