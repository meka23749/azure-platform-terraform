   locals {
     name = "${var.project}-${var.environment}"

     tags = merge({
       project     = var.project
       environment = var.environment
       managed_by  = "terraform"
     }, var.tags)
   }

   data "azurerm_client_config" "current" {}

   resource "azurerm_resource_group" "main" {
     name     = "rg-${local.name}"
     location = var.location
     tags     = local.tags
   }