output "resource_group_name" {
  description = "Resource group of the state backend"
  value       = azurerm_resource_group.state.name
}

output "storage_account_name" {
  description = "Storage account of the state backend"
  value       = azurerm_storage_account.state.name
}

output "container_name" {
  description = "Blob container for the state files"
  value       = azurerm_storage_container.state.name
}

output "backend_config" {
  description = "Content for infra/environments/backend-dev.hcl"
  value       = <<-EOT
    resource_group_name  = "${azurerm_resource_group.state.name}"
    storage_account_name = "${azurerm_storage_account.state.name}"
    container_name       = "${azurerm_storage_container.state.name}"
    key                  = "dev.terraform.tfstate"
    use_azuread_auth     = true
  EOT
}
