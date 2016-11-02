variable "kontena_master_count" { default = 0 }
variable "kontena_node_count" { default = 0 }
variable "kontena_mongo_count" { default = 0 }

# MONGO
variable "mongo_image" { default = "mongo" }
variable "mongo_version" { default = "3.0" }
variable "mongo_bind_ip" { default = "0.0.0.0" }

# KONTENA-MASTER
variable "kontena_master_image" { default = "kontena/server" }
variable "kontena_master_version" { default = "latest" }
variable "kontena_master_mongodb_host" { default = "notset" }

variable "kontena_master_vault_iv" {
  default = "konterraformdefaultmastervaultivkonterraformdefaultmastervaultivkonterraformdefaultmastervaultiv"
}
variable "kontena_master_vault_key" {
  default = "konterraformdefaultmastervaultkeykonterraformdefaultmastervaultkeykonterraformdefaultmastervault"
}
variable "kontena_master_initial_admin_code" {
  default = "konterraforminitialadmincode"
}

variable "kontena_master_max_threads" { default = "16" }
variable "kontena_master_web_concurrency" { default = "2" }
variable "kontena_master_coreos_write_files_ssl_cert" { default = "" }

# KONTENA-AGENT
variable "kontena_agent_image" { default = "kontena/agent" }
variable "kontena_agent_version" { default = "latest" }
variable "kontena_agent_peer_interface" { default = "eth0" }
variable "kontena_agent_master_uri" { default = "http://notset.example.org"}
variable "kontena_agent_token" { default = "notset" }
variable "kontena_agent_memory_limit" { default = "256m" }

# MONGO-BACKUP
variable "kontena_mongo_backup_image" { default = "kontena/mongo-backup" }
variable "kontena_mongo_backup_version" { default = "3.0" }
variable "kontena_mongo_backup_interval" { default = "3h" }
variable "kontena_mongo_backup_s3_path" { default = "kontena_master" }

# log-archiver
variable "kontena_log_archiver_image" { default = "kontena/log-archiver" }
variable "kontena_log_archiver_version" { default = "latest" }

# ha-proxy
variable "kontena_haproxy_image" { default = "kontena/haproxy" }
variable "kontena_haproxy_version" { default = "latest" }
