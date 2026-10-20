variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "project" {
  description = "Short project name (lowercase letters and digits)"
  type        = string
  default     = "aiplat"
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be dev, test or prod."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "germanywestcentral"
}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  type        = string
  default     = "10.20.0.0/16"
}

variable "container_image" {
  description = "Container image of the app (default: Microsoft quickstart image)"
  type        = string
  default     = "mcr.microsoft.com/k8se/quickstart:latest"
}

variable "container_target_port" {
  description = "Port the container listens on (quickstart: 80, own FastAPI app: 8000)"
  type        = number
  default     = 80
}

variable "use_acr_image" {
  description = "Set to true once your own image is in the Azure Container Registry"
  type        = bool
  default     = false
}

variable "kv_public_access" {
  description = "Public network access to Key Vault (true in dev so hosted pipeline agents can write secrets)"
  type        = bool
  default     = true
}

variable "monthly_budget_eur" {
  description = "Monthly budget for the resource group in EUR"
  type        = number
  default     = 20
}

variable "budget_start_date" {
  description = "Budget start date (first day of a month, format 2026-11-01T00:00:00Z)"
  type        = string
}

variable "budget_contact_emails" {
  description = "Email addresses for budget alerts"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
