
output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "storage_account" {
  value = azurerm_storage_account.storage.name
}

output "ingest_function_name" {
  value = azurerm_function_app.ingest.name
}

output "report_function_name" {
  value = azurerm_function_app.report.name
}
