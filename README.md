# cluster

## Setup
* create a GCP service account 
* give it the following roles:
```
roles/compute.admin
roles/iam.serviceAccountUser
roles/resourcemanager.projectIamAdmin
roles/container.admin
```
* create a bucket and give read/write permissions to the service account
* dump the service account keyfile into `config/tf-gke-cluster-key.json`
* populate vars in `cluster/terraform.tfvars`
* create cluster
* create nginx ingress controller
