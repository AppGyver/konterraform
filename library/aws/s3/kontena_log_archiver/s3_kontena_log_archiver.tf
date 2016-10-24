resource "aws_iam_user" "kontena_log_archiver" {
    name = "${var.name}-kontena-log-archiver"
    path = "/"
}

resource "aws_iam_access_key" "kontena_log_archiver" {
    user = "${aws_iam_user.kontena_log_archiver.name}"
}

resource "aws_iam_user_policy" "kontena_log_archiver" {
    name = "test"
    user = "${aws_iam_user.kontena_log_archiver.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.kontena_log_archiver.arn}",
        "${aws_s3_bucket.kontena_log_archiver.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "kontena_log_archiver" {
    bucket = "${var.name}-kontena-logs"
    acl = "private"

    force_destroy = true

    lifecycle_rule {
        id = "master_logs_minutely"
        prefix = "master_logs_minutely/"
        enabled = true

        abort_incomplete_multipart_upload_days = 7

        transition {
            days = 30
            storage_class = "STANDARD_IA"
        }

        transition {
            days = 90
            storage_class = "GLACIER"
        }

        expiration {
            days = 365
        }
    }
}
