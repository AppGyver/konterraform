# megamaster

Master(s) + ALB with HTTPS + Single Mongo

## vars/aws-megamaster.tfvars

```
name = "megamaster"

aws_profile = ""
aws_region = ""

ssh_public_key_file = "~/.ssh/id_rsa.pub"

aws_alb_cert_master = "certs/yourdomain.com.crt"
aws_alb_key_master = "certs/yourdomain.com.key"

kontena_master_version = "latest"

kontena_mongosingle_count = "1"
kontena_master_count = "1"

# recipe will append here:
```

## running
```
recipes/aws/megamaster/create
```
