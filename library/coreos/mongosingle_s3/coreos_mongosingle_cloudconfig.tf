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

    mongo_version = "${var.mongo_version}"
    bind_ip = "${var.mongo_bind_ip}"

    name = "${var.name}"

    LOG_ARCHIVER_S3_ACCESS_KEY = "${aws_iam_access_key.kontena_log_archiver.id}"
    LOG_ARCHIVER_S3_SECRET_KEY = "${aws_iam_access_key.kontena_log_archiver.secret}"
    LOG_ARCHIVER_S3_REGION = "${aws_s3_bucket.kontena_log_archiver.region}"
    LOG_ARCHIVER_S3_BUCKET = "${replace(aws_s3_bucket.kontena_log_archiver.arn, "arn:aws:s3:::", "")}"

    mongo_backup_version = "${var.kontena_mongo_backup_version}"
    MONGO_BACKUP_INTERVAL = "${var.kontena_mongo_backup_interval}"
    MONGO_BACKUP_S3_ACCESS_KEY = "${aws_iam_access_key.kontena_mongo_backup.id}"
    MONGO_BACKUP_S3_SECRET_KEY = "${aws_iam_access_key.kontena_mongo_backup.secret}"
    MONGO_BACKUP_S3_REGION = "${aws_s3_bucket.kontena_mongo_backup.region}"
    MONGO_BACKUP_S3_BUCKET = "${replace(aws_s3_bucket.kontena_mongo_backup.arn, "arn:aws:s3:::", "")}"
    MONGO_BACKUP_S3_PATH = "${var.kontena_mongo_backup_s3_path}"
  }
}
