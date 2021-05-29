variable "rg" {
        description = "Name of the resource groupt to be created"
        type = string
        default = "practice-rg"
}

variable "loc" {
    description = "Reaources location"
    type = string
    default = "eastus2"
}

variable "address_space" {
    description = "Address space creation"
    type = list
}

variable "subnet" {
}

variable "subnetname"{
    default = "subnet1"
}

variable "vmname"{
    description = "Please Enter server name:"

}