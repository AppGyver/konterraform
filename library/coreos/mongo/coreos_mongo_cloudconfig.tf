data "template_file" "coreos_cloudconfig_mongo" {
  count = "${var.kontena_mongo_count}"

  template = "${file("library/coreos/mongo/coreos_mongo_cloudconfig.yml")}"

  vars {
    mongo_version = "${var.kontena_mongo_version}"
    bind_ip = "${var.kontena_mongo_bind_ip}"

    mongo_opts = "--replSet 'kontena-server-rs'"
  }
}
