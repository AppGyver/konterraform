variable "ssh_public_key_file" {}

resource "aws_key_pair" "kontena" {
  key_name = "${var.name}"
  public_key = "${file(var.ssh_public_key_file)}"
}
