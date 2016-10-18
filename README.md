# Konterraform

A bit like https://github.com/kz8s/tack/

Components:

* `recipes/` contains scripts to create different styles of Kontena environments from..
* .. `stages/` that tell which components in ..
* .. `library/` needs to be symlinked to ..
* .. `blueprints/` that stores bunch of `.tf` files that Terraform will merge as one.

State:

* `state/` contains the state of the blueprint.
* `vars/` contains the variables for the blueprint.

Keep `vars/` and `blueprints/` in git !

Additionally:

* `helpers/` has scripts that tie together various pieces in ..
* .. `bin/` where sensible defaults are set for Terraform commands

Features:

* Has sensible defaults
* All machines are deployed on different subsets (count % number of available az's)
* Stores the state in git
* Sets Kontena node labels automatically
* Asks for input if no var file is given
* ..and more!

## setup

```
brew bundle
bundle install    # for helpers/kontena_login.rb to work
```

Create `vars/aws-singlemongoalbed.tfvars`
```
name = "yourprefix"

aws_profile = "<configured_aws_profile>"
aws_region = "eu-west-1"

ssh_public_key_file = "~/.ssh/id_rsa.pub"

kontena_master_version = "latest"
kontena_agent_version = "latest"

kontena_mongosingle_count = "1"
kontena_master_count = "2"
kontena_node_count = "3"

# remove these after you are not constantly destroying the environment
aws_instance_mongosingle_disable_api_termination = "false"
aws_instance_mongosingle_root_block_device_delete_on_termination = "true"

aws_instance_node_disable_api_termination = "false"
aws_instance_node_root_block_device_delete_on_termination = "true"

# the recipe will append variables under this line (the last one wins)
```

### Using different CIDR block

Note: Weave network `10.81.0.0/16` can not be changed, so don't use that for your VPC.

```
aws_vpc_cidr_block = "10.32.0.0/16"
aws_public_subnet_cidr_blocks = ["10.32.1.0/24", "10.32.2.0/24", "10.32.3.0/24"]
coreos_node_dns_server = "10.32.0.2"
```

### Master SSL

Use ALB with HTTPS or:

```
kontena_master_coreos_write_files_ssl_cert = "
  - path: /etc/kontena-server.pem
    permissions: 0600
    owner: root
    content: |
      -----BEGIN CERTIFICATE-----
      ...
```

## running

```
recipes/aws/singlemongoalbed/create GRIDNAME 3 admin@example.com registered_admin_password
```

Change settings in `vars` and run `bin/update aws singlemongoalbed`

Destroy with `recipes/aws/singlemongoalbed/destroy`

## PRO-TIPS

- Sometimes when `destroying...` for a long time you can speed it up by going to AWS console and destroying the resource from there.
- Sometimes when `destroying...` it can be that an extra resource is running and preventing the deletion (go to AWS console and delete that)
- Set `KONTERRAFORM_FRONTEND=noninteractive` for fully automated setup
- Taint (force recreate) with `bin/taint aws singlemongoalbed null_resource.kontena_provisioner_node_first.0`

## TODO

- [ ] AWS DNS enabled check in core os template
- [ ] test master and node reboot schedules
- [ ] create .tfvars example in recipe that is intialized
- [ ] Use autoscaling groups?
- [ ] Set weave trusted subnets "turbomode"

## terraform pls

* config: provisioner splat vars can only reference other resources - https://github.com/hashicorp/terraform/pull/1016
* Intermediate variables (OR: add interpolation support to input variables) - https://github.com/hashicorp/terraform/issues/4084
* Unable to use output variable as list - https://github.com/hashicorp/terraform/issues/8048
* Autoload `*.tfvars` in the same way as `*.tf` (allow inheritance) - https://github.com/hashicorp/terraform/issues/1084
* Using element with splat reference should scope dependency to selected resource  - https://github.com/hashicorp/terraform/issues/3449
 * Adding / removing nodes will temporarily delete all ALB attachments potentially causing minimal downtime.
* Various template errors are really hard to debug if there is a syntax error somewhere
