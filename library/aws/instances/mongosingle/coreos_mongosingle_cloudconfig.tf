variable "coreos_mongosingle_locksmith_window_start" { default = "Tue 08:00" }
variable "coreos_mongosingle_locksmith_window_length" { default = "1h" }
variable "coreos_mongosingle_update_reboot_strategy" { default = "off" }

data "template_file" "coreos_cloudconfig_mongosingle" {
  count = "${var.kontena_mongo_count}"

  template = "${file("library/coreos/mongosingle/coreos_mongosingle_cloudconfig.yml")}"

  vars {
    coreos_locksmith_window_start = "${var.coreos_mongosingle_locksmith_window_start}"
    coreos_locksmith_window_length = "${var.coreos_mongosingle_locksmith_window_length}"
    coreos_update_reboot_strategy = "${var.coreos_mongosingle_update_reboot_strategy}"

    mongo_version = "${var.mongo_version}"
    bind_ip = "${var.mongo_bind_ip}"
  }
}
