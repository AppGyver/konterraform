resource "aws_iam_user" "kontena_mongo_backup" {
    name = "${var.name}-kontena-mongo-backup"
    path = "/"
}

resource "aws_iam_access_key" "kontena_mongo_backup" {
    user = "${aws_iam_user.kontena_mongo_backup.name}"
}

resource "aws_iam_user_policy" "kontena_mongo_backup" {
    name = "${var.name}_s3_rw_kontena-mongo-backups"
    user = "${aws_iam_user.kontena_mongo_backup.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.kontena_mongo_backup.arn}",
        "${aws_s3_bucket.kontena_mongo_backup.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "kontena_mongo_backup" {
    bucket = "${var.name}-kontena-mongo-backups"
    acl = "private"

    force_destroy = true

    lifecycle_rule {
        id = "kontena_mongo_backups"
        prefix = "kontena_master/"
        enabled = true

        abort_incomplete_multipart_upload_days = 3

        transition {
            days = 14
            storage_class = "GLACIER"
        }

        expiration {
            days = 365
        }
    }
}
