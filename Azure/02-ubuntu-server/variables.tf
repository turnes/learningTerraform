variable "subscription_id" {
    type = string
}

variable "resource_prefix" {
    type = string
    default = "Server"
}

variable "rg_name" {
    type    = string
    default = "scenario2"
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
    default = "Scenario-Vnet"
 }

 variable "vnet_address_space" {
    type = list(string)
    default = ["10.0.0.0/16","192.168.0.0/16"]

 }

 variable "subnet_name" {
     type = string
     default = "Public"
 }

 variable "subnet_prefixes" {
     type = list(string)
     default = ["10.0.1.0/24"]
 }

 variable "public_IP" {
     type = string
     default = "ubuntu_server"
 }

 variable "security_group_name" {
     type  = string
     default = "server_nsg"
 }

 variable "vm_name" {
     type = string
     default = "UbuntuServer"
 }

 variable "vm_size" {
     type = string 
     default = "Standard_DS1_v2"
 }

 variable "vm_hostname" {
     type = string
     default = "ubuntu"
 }

 variable "vm_username" {
     type = string
     default = "ubuntu"
 }

 variable "vm_password" {
     type = string
 }