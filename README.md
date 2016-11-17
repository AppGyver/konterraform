# Konterraform

A bit like https://github.com/kz8s/tack/

Konterraform creates a single folder with bunch of symlinks so that the folder becomes a single terraform file - this allows creation of different Kontena setups from simple (1 VM for master/mongo and 1 VM for node(s)) to complex (a separate mongo, multiple HA masters with AWS ALB and a separated "Master grid" with Kontena Masters deployed with Kontena that form another grid for the actual services) with reusable components. This symlinking approach is a workaround to solve various issues in Terraform 0.7's module support (see "terraform pls" at the end of this README).

All Terraform resources are configured with variables so that you can change the infrastructure by changing the variables, not by modifying the terraform files. Variables have been set to sensible defaults so that the number of required changes would be low (at least for initial testing.)

Supported environments:

* AWS (this document)
* [Azure](README.azure.md)

WIP environments:

* [GCP](README.gcp.md)
* Packet
* Softlayer

Components:

* `recipes/` contains scripts to create different styles of Kontena environments from..
* .. `stages/` that tell which components in ..
* .. `library/` needs to be symlinked to ..
* .. `blueprints/` that stores bunch of `.tf` files that Terraform will merge as one.


* `state/` contains the state of the blueprint.
* `vars/` contains the variables for the blueprint.

You prob. want to keep `vars/`, `state/` and `blueprints/` in git !

Additionally:

* `helpers/` has scripts that tie together various pieces in ..
* .. `bin/` where sensible defaults are set for Terraform commands


## Setup

```
$ brew bundle
$ bundle install    # for helpers/kontena_login.rb to work
$ kontena version   # ensure that you have the kontena cli installed
```

## Quick Start

Konterraform ships with `recipes` that are BASH scripts gluing everything together.

A recipe `singlemongoalbed` creates 1 mongo, N master(s) and N nodes.

Step 1: create `vars/aws-singlemongoalbed.tfvars` with following contents:

```
name = "yourprefix"

aws_profile = "<configured_aws_profile>"
aws_region = "eu-west-1"

ssh_public_key_file = "~/.ssh/id_rsa.pub"

kontena_master_version = "latest"
kontena_agent_version = "latest"

kontena_mongo_count = "1"
kontena_master_count = "2"
kontena_node_count = "3"

# remove these after you are not constantly destroying the environment
aws_instance_mongosingle_disable_api_termination = "false"
aws_instance_mongosingle_root_block_device_delete_on_termination = "true"

aws_instance_node_disable_api_termination = "false"
aws_instance_node_root_block_device_delete_on_termination = "true"

# the recipe will append variables under this line (the last one wins)
# NOTE: have an empty line after this line so that the appending works :)

```

Step 2: Run the script

`$ recipes/aws/singlemongoalbed/create yourmastername yourgridname 3`

Accept changes by pressing enter or by setting `KONTERRAFORM_FRONTEND=noninteractive` environment variable.

Step 3: Profit!

```
$ kontena grid show yourgridname
yourgridname:
  uri: ws://yourprefix-kontena-master-581130411.eu-west-1.elb.amazonaws.com
  stats:
    nodes: 3 of 3
    cpus: 3
    load: 0.01 0.07 0.06
    memory: 0.96 of 11.04 GB
    filesystem: 1.01 of 737.16 GB
    users: 1
    services: 0
    containers: 18
```

Step 4: Updating & Destroying

Change settings in `vars/` and run `bin/update aws singlemongoalbed`

Destroy with `bin/destroy aws singlemongoalbed`


## Advanced usage

Create a symlink from `master` recipe to your own name.

```
$ ln -s singlemongoalbed recipes/aws/singlemongoalbed
$ cat > vars/aws-singlemongoalbed.tfvars
$ recipes/aws/singlemongoalbed/create
```

Then do the same for `nodegrid` AND override the default CIDR block (because each recipe creates it's own VPC, see below)

```
$ ln -s nodegrid recipes/aws/mynodegrid
$ cat > vars/mynodes.tfvars
$ recipes/aws/mynodes/create yourmastername yourgridname 3 http://<mymasterurl>
```

### Using different CIDR blocks

Note: Weave network `10.81.0.0/16` can not be changed, so don't use that for your VPC.

```
aws_vpc_cidr_block = "10.32.0.0/16"
aws_public_subnet_cidr_blocks = ["10.32.1.0/24", "10.32.2.0/24", "10.32.3.0/24"]
coreos_node_dns_server = "10.32.0.2"
```

## Updating Kontena

For automatic updates use the tag `:latest` and reboot the servers when you want to update.

For more controlled releases you should run Kontena images from your own repositories.

The included script:
```
helpers/tag_kontena_release 0.16.1 yournamespace yourtag
```
will pull `kontena/server:0.16.1` and `kontena/agent:0.16.1` and push them to Dockerhub at `yournamespace/kontena-{server/agent}:yourtag`


There is also another script:

```
helpers/tag_kontena_support yournamespace yourtag
```

that will "snapshot" `mongo:3.0`, `kontena-haproxy`, `kontena/mongo-backup:3.0` and `kontena/log-archiver` at current time from whatever is the `:latest` when the command is run.


## PRO-TIPS

- Terraform supports overrides https://www.terraform.io/docs/configuration/override.html
- Sometimes when `destroying...` for a long time you can speed it up by going to AWS console and destroying the resource from there.
- Sometimes when `destroying...` it can be that an extra resource is running and preventing the deletion (go to AWS console and delete that)
- Set `KONTERRAFORM_FRONTEND=noninteractive` for fully automated setup
- Taint (force recreate) with `bin/taint aws singlemongoalbed null_resource.kontena_provisioner_node_first.0`
- See systemd failures with: `systemctl status failed-service`
- S3 requires that resource names do not use dashes, so you can not use `something_something` as a name (or in your prefix)

## terraform pls

* config: provisioner splat vars can only reference other resources - https://github.com/hashicorp/terraform/pull/1016
* Intermediate variables (OR: add interpolation support to input variables) - https://github.com/hashicorp/terraform/issues/4084
* Unable to use output variable as list - https://github.com/hashicorp/terraform/issues/8048
* Autoload `*.tfvars` in the same way as `*.tf` (allow inheritance) - https://github.com/hashicorp/terraform/issues/1084
* Using element with splat reference should scope dependency to selected resource  - https://github.com/hashicorp/terraform/issues/3449
 * Adding / removing nodes will temporarily delete all ALB attachments potentially causing minimal downtime.
* Various template errors are really hard to debug if there is a syntax error somewhere

## systemd pls
* Service doesn't enter the "failed" state (coreos stable has 229, fixed in 230 -- mongo init retry is not possible..)- https://github.com/systemd/systemd/issues/3166
