variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "project" {
  description = "Short project name (lowercase letters and digits, max. 8 characters)"
  type        = string
  default     = "aiplat"

  validation {
    condition     = can(regex("^[a-z0-9]{2,8}$", var.project))
    error_message = "project may only contain lowercase letters and digits (2 to 8 characters)."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "swedencentral"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    managed_by = "terraform"
    purpose    = "tfstate"
  }
}
