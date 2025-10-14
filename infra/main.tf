########################################
# Azure Event-Driven Data Pipeline Infra
########################################

resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# Storage Account (no allow_blob_public_access - deprecated)
resource "azurerm_storage_account" "storage" {
  name                     = lower(replace("${var.project_name}stg", "_", ""))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Blob Containers
resource "azurerm_storage_container" "raw" {
  name                  = "raw"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "processed" {
  name                  = "processed"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "reports" {
  name                  = "reports"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# Updated App Service Plan (new resource type)
resource "azurerm_service_plan" "plan" {
  name                = "${var.project_name}-plan"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1" # Consumption plan for Functions
}

# Application Insights
resource "azurerm_application_insights" "ai" {
  name                = "${var.project_name}-ai"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

# Function App - Ingest Function
resource "azurerm_function_app" "ingest" {
  name                       = "${var.project_name}-ingest"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  version                    = "~4"

  site
