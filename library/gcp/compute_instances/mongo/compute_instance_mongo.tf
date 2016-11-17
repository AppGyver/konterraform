resource "google_compute_instance" "kontena_mongo" {
  count = "${var.kontena_mongo_count}"

  disk {
    image = "coreos-cloud/coreos-stable-1185-3-0-v20161101"
    auto_delete = true
    type = "pd-ssd"
    size = "10"
  }

  machine_type = "g1-small"
  name = "${var.name}-kontena-mongo-${count.index}"
  zone = "${var.gcp_region}-a"

  network_interface {
    network = "${var.name}-kontena"
    access_config {
      nat_ip = "${google_compute_address.kontena_mongo.address}"
    }
  }

  scheduling = {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
  }

  tags = ["${var.name}-kontena"]
}
