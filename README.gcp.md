# Konterraform GCP

Does not use instance templates / groups because of terraform issue 8866

```
name = "<prefix>"
gcp_project = "<project-name-in-google-cloud>"
gcp_region = "us-central1"
gcp_credientials_json_path = "~/credentials.json"
```

## PRO-TIPS

- List machine types with `gcloud compute machine-types list`

## google pls

- Feature Request: support regional google instance group managers - https://github.com/hashicorp/terraform/issues/8866
