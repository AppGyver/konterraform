# AWS
variable "aws_instance_ami_id_by_virtualization_type" {
  default = {
    "HVM" = "ami-e3d6ab90",
    "PV" = "ami-58d5a82b"
  }
}

variable "kontena_master_count" { default = 0 }
variable "kontena_node_count" { default = 0 }
variable "kontena_mongosingle_count" { default = 0 }

variable "aws_instance_master_type" { default = "m3.medium" }
variable "aws_instance_master_virtualization_type" { default = "HVM" }
variable "aws_instance_master_root_block_device_volume_type" { default = "gp2" }
variable "aws_instance_master_root_block_device_volume_size" { default = 100 }
variable "aws_instance_master_root_block_device_delete_on_termination" { default = true }
variable "aws_instance_master_disable_api_termination" { default = false }

variable "aws_instance_mastermongo_type" { default = "m3.medium" }
variable "aws_instance_mastermongo_virtualization_type" { default = "HVM" }
variable "aws_instance_mastermongo_root_block_device_volume_type" { default = "gp2" }
variable "aws_instance_mastermongo_root_block_device_volume_size" { default = 100 }
variable "aws_instance_mastermongo_root_block_device_delete_on_termination" { default = true }
variable "aws_instance_mastermongo_disable_api_termination" { default = false }

variable "aws_instance_node_type" { default = "m3.medium" }
variable "aws_instance_node_virtualization_type" { default = "HVM" }
variable "aws_instance_node_associate_public_ip_address" { default = true }
variable "aws_instance_node_root_block_device_volume_type" { default = "gp2" }
variable "aws_instance_node_root_block_device_volume_size" { default = 256 }
variable "aws_instance_node_root_block_device_delete_on_termination" { default = true }
variable "aws_instance_node_disable_api_termination" { default = true }

variable "aws_instance_mongosingle_type" { default = "m3.large" }
variable "aws_instance_mongosingle_virtualization_type" { default = "HVM" }
variable "aws_instance_mongosingle_root_block_device_volume_type" { default = "gp2" }
variable "aws_instance_mongosingle_root_block_device_volume_size" { default = 100 }
variable "aws_instance_mongosingle_root_block_device_delete_on_termination" { default = true }
variable "aws_instance_mongosingle_disable_api_termination" { default = true }

# MONGO
variable "mongo_version" { default = "3.0" }
variable "mongo_bind_ip" { default = "0.0.0.0" }

# KONTENA-MASTER
variable "kontena_master_version" { default = "latest" }
variable "kontena_master_mongodb_host" { default = "notset" }

variable "kontena_master_vault_iv" {
  default = "konterraformdefaultmastervaultivkonterraformdefaultmastervaultivkonterraformdefaultmastervaultiv"
}
variable "kontena_master_vault_key" {
  default = "konterraformdefaultmastervaultkeykonterraformdefaultmastervaultkeykonterraformdefaultmastervault"
}
variable "kontena_master_max_threads" { default = "8" }
variable "kontena_master_web_concurrency" { default = "2" }

# KONTENA-AGENT
variable "kontena_agent_version" { default = "latest" }
variable "kontena_agent_peer_interface" { default = "eth0" }
variable "kontena_agent_master_uri" { default = "http://notset.example.org"}
variable "kontena_agent_token" { default = "notset" }
variable "kontena_agent_memory_limit" { default = "256m" }
