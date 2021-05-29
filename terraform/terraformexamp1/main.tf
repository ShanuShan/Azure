resource "azurerm_resource_group" "rg" {
    location="eastus2"
    name=var.resourcegroup
}
resource "azurerm_resource_group" "rg1"{
    location="eastus2"
    name=var.resourcegrp
}