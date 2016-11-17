resource "google_compute_network" "kontena" {
  name       = "${var.name}-kontena"
  auto_create_subnetworks = true
}
