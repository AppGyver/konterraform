variable "aws_alb_cert_master" {}
variable "aws_alb_key_master" {}

resource "aws_iam_server_certificate" "kontena_master" {
  name_prefix = "${var.name}-kontena-master"
  lifecycle {
    create_before_destroy = true
  }

  certificate_body = "${file("${var.aws_alb_cert_master}")}"
  private_key = "${file("${var.aws_alb_key_master}")}"
}
