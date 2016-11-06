variable "coreos_mongosingle_locksmith_window_start" { default = "Tue 08:00" }
variable "coreos_mongosingle_locksmith_window_length" { default = "1h" }
variable "coreos_mongosingle_update_reboot_strategy" { default = "off" }

data "template_file" "coreos_cloudconfig_mongosingle" {
  count = "${var.kontena_mongo_count}"

  template = "${file("library/coreos/mongosingle_s3/coreos_mongosingle_cloudconfig.yml")}"

  vars {
    coreos_locksmith_window_start = "${var.coreos_mongosingle_locksmith_window_start}"
    coreos_locksmith_window_length = "${var.coreos_mongosingle_locksmith_window_length}"
    coreos_update_reboot_strategy = "${var.coreos_mongosingle_update_reboot_strategy}"

    kontena_mongo_image =  "${var.kontena_mongo_image}"
    kontena_mongo_version = "${var.kontena_mongo_version}"
    kontena_mongo_bind_ip = "${var.kontena_mongo_bind_ip}"

    name = "${var.name}"

    kontena_log_archiver_image = "${var.kontena_log_archiver_image}"
    kontena_log_archiver_version = "${var.kontena_log_archiver_version}"

    kontena_log_archiver_s3_access_key = "${aws_iam_access_key.kontena_log_archiver.id}"
    kontena_log_archiver_s3_secret_key = "${aws_iam_access_key.kontena_log_archiver.secret}"
    kontena_log_archiver_s3_region = "${aws_s3_bucket.kontena_log_archiver.region}"
    kontena_log_archiver_s3_bucket = "${replace(aws_s3_bucket.kontena_log_archiver.arn, "arn:aws:s3:::", "")}"

    kontena_mongo_backup_image = "${var.kontena_mongo_backup_image}"
    kontena_mongo_backup_version = "${var.kontena_mongo_backup_version}"

    kontena_mongo_backup_interval = "${var.kontena_mongo_backup_interval}"
    kontena_mongo_backup_s3_access_key = "${aws_iam_access_key.kontena_mongo_backup.id}"
    kontena_mongo_backup_s3_secret_key = "${aws_iam_access_key.kontena_mongo_backup.secret}"
    kontena_mongo_backup_s3_region = "${aws_s3_bucket.kontena_mongo_backup.region}"
    kontena_mongo_backup_s3_bucket = "${replace(aws_s3_bucket.kontena_mongo_backup.arn, "arn:aws:s3:::", "")}"
    kontena_mongo_backup_s3_path = "${var.kontena_mongo_backup_s3_path}"
  }
}
