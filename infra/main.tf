

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# Storage Account
resource "azurerm_storage_account" "storage" {
  name = lower(replace(replace("${var.project_name}stg", "_", ""), "-", ""))
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

# Function App Plan (replaces deprecated azurerm_app_service_plan)
resource "azurerm_service_plan" "plan" {
  name                = "${var.project_name}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
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

# Ingest Function App
resource "azurerm_linux_function_app" "ingest" {
  name                = "${var.project_name}-ingest"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  https_only          = true

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"              = "python"
    "AzureWebJobsStorage"                   = azurerm_storage_account.storage.primary_connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.ai.connection_string
  }

  identity {
    type = "SystemAssigned"
  }
}

# Report Function App
resource "azurerm_linux_function_app" "report" {
  name                = "${var.project_name}-report"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  https_only          = true

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"              = "python"
    "AzureWebJobsStorage"                   = azurerm_storage_account.storage.primary_connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.ai.connection_string
  }

  identity {
    type = "SystemAssigned"
  }
}
