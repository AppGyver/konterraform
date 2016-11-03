# AWS
variable "aws_instance_ami_id_by_virtualization_type" {
  default = {
    "HVM" = "ami-e3d6ab90",
    "PV" = "ami-58d5a82b"
  }
}

variable "aws_instance_master_type" { default = "m3.medium" }
variable "aws_instance_master_virtualization_type" { default = "HVM" }
variable "aws_instance_master_root_block_device_volume_type" { default = "gp2" }
variable "aws_instance_master_root_block_device_volume_size" { default = 32 }
variable "aws_instance_master_root_block_device_delete_on_termination" { default = true }
variable "aws_instance_master_disable_api_termination" { default = false }
variable "aws_instance_master_ebs_optimized" { default = false }

variable "aws_instance_node_type" { default = "m3.medium" }
variable "aws_instance_node_virtualization_type" { default = "HVM" }
variable "aws_instance_node_associate_public_ip_address" { default = true }
variable "aws_instance_node_root_block_device_volume_type" { default = "gp2" }
variable "aws_instance_node_root_block_device_volume_size" { default = 256 }
variable "aws_instance_node_root_block_device_delete_on_termination" { default = false }
variable "aws_instance_node_disable_api_termination" { default = true }
variable "aws_instance_node_ebs_optimized" { default = false }

variable "aws_instance_mongosingle_type" { default = "m3.large" }
variable "aws_instance_mongosingle_virtualization_type" { default = "HVM" }
variable "aws_instance_mongosingle_root_block_device_volume_type" { default = "gp2" }
variable "aws_instance_mongosingle_root_block_device_volume_size" { default = 100 }
variable "aws_instance_mongosingle_root_block_device_delete_on_termination" { default = false }
variable "aws_instance_mongosingle_disable_api_termination" { default = true }
variable "aws_instance_mongosingle_ebs_optimized" { default = false }
