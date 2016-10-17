# nodegrid

## vars/aws-nodegrid.tfvars

```
name = "nodegrid"

aws_profile = ""
aws_region = ""

ssh_public_key_file = "~/.ssh/id_rsa.pub"

kontena_agent_version = "latest"
kontena_node_count = "3"

# recipe will append here:
```

## running
```
SSL_IGNORE_ERRORS=true recipes/aws/nodegrid/create GRIDNAME INITIALSIZE LOGIN PASS MASTER_URL
```
