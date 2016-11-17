variable "gcp_project" {}
variable "gcp_region" {}
variable "gcp_credientials_json_path" {}

provider "google" {
  credentials = "${file("${var.gcp_credientials_json_path}")}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}
