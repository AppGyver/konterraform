variable "coreos_master_locksmith_window_start_prefix" { default = "Tue 08:0" }
variable "coreos_master_locksmith_window_length" { default = "1h" }
variable "coreos_master_update_reboot_strategy" { default = "reboot" }

data "template_file" "coreos_cloudconfig_master" {
  count = "${var.kontena_master_count}"

  template = "${file("library/coreos/master/coreos_master_cloudconfig.yml")}"

  vars {
    coreos_locksmith_window_start = "${var.coreos_master_locksmith_window_start_prefix}${count.index * 3 % 60}"
    coreos_locksmith_window_length = "${var.coreos_master_locksmith_window_length}"
    coreos_update_reboot_strategy = "${var.coreos_master_update_reboot_strategy}"

    kontena_master_image = "${var.kontena_master_image}"
    kontena_master_version = "${var.kontena_master_version}"

    kontena_haproxy_image = "${var.kontena_haproxy_image}"
    kontena_haproxy_version = "${var.kontena_haproxy_version}"

    mongodb_uri = "mongodb://${var.kontena_master_mongodb_host}:27017/${var.name}_master"

    vault_iv = "${var.kontena_master_vault_iv}"
    vault_key = "${var.kontena_master_vault_key}"
    max_threads = "${var.kontena_master_max_threads}"
    web_concurrency = "${var.kontena_master_web_concurrency}"
    initial_admin_code = "${var.kontena_master_initial_admin_code}"

    write_files_ssl_cert = "${var.kontena_master_coreos_write_files_ssl_cert}"
  }
}
