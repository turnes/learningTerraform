

## How to use
Each folder is a project. In each project you should create `terraform.tfvars` file. The content of this contains sensitive data, so never publish it in github.

For each variable in `variables.tf` you need to in `terraform.tfvars`.

Ex:
**`variables.tf`**
``` terraform
variable "subscription_id" {
  type = string  
}

variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}
```
Your **`terraform.tfvars`** should be

``` terraform
subscription_id = "your_subscription_id"
region = "westus2"
rg_name = "learning-tf"

```



## Useful AZ commands

```
# S U B S C R I P T I O N S
az account list -o table
az account show
az account set subscription_id

# R E G I O N S
az account list-locations -o table
```