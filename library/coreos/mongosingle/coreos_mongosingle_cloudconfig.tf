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

    kontena_mongo_image =  "${var.kontena_mongo_image}"
    kontena_mongo_version = "${var.kontena_mongo_version}"
    kontena_mongo_bind_ip = "${var.kontena_mongo_bind_ip}"
  }
}
