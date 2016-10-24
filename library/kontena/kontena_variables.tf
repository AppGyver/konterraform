variable "kontena_master_count" { default = 0 }
variable "kontena_node_count" { default = 0 }
variable "kontena_mongo_count" { default = 0 }

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
variable "kontena_master_max_threads" { default = "16" }
variable "kontena_master_web_concurrency" { default = "2" }
variable "kontena_master_coreos_write_files_ssl_cert" { default = "" }

# KONTENA-AGENT
variable "kontena_agent_version" { default = "latest" }
variable "kontena_agent_peer_interface" { default = "eth0" }
variable "kontena_agent_master_uri" { default = "http://notset.example.org"}
variable "kontena_agent_token" { default = "notset" }
variable "kontena_agent_memory_limit" { default = "256m" }