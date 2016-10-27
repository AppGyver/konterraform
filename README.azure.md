# Konterraform Azure

See [README.md](README.md) for general usage and Terraform AzureRM docs on how to get secrets (you have to to the classic portal, the alternative method described didn't work).

```
name = "yourprefix"

azure_subscription_id = "from portal"
azure_client_id = "from classic portal"
azure_client_secret = "from classic portal"
azure_tenant_id = "from classic portal"

azure_location = "West Europe"

kontena_master_version = "0.15.5"
kontena_node_version = "0.15.5"

kontena_mongo_count = "1"
kontena_master_count = "1"
kontena_node_count = "3"
```

```
$ recipes/azure/singlemongolbed yourgrid initial_nodes admin@example.com password
```

## PRO TIPS
- Virtual machine storage image reference values can be seen by creating a new machine and inspecting the template it will use. Even if you don't create the machine the wizard will create a resource group that needs to be deleted..
- VM sizes are here: https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-sizes/
- 32gb of premium storage "Page blob" will cost ~18eur/mo

## TODO
- other DNS server instead of 8.8.4.4 ?
