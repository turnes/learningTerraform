variable "subscription_id" {
    type = string
}

variable "rg_name" {
    type    = string
    default = "scenario4"
}

variable "location" {
    type    = string
    default = "westus2"
}

variable "tags" {
    type = map
    default = {
        "ENV" = "Dev"
        "TEAM" = "DevOps"
    }
}

 variable "vnet_name" {
    type = string
    default = "Scenario3-Vnet"
 }

  variable "vnet_address_space" {
    type = list(string)
    default = ["10.0.0.0/16"]
 }
