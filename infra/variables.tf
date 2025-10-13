
variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "azure-event-pipeline"
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
  default     = "East US"
}
