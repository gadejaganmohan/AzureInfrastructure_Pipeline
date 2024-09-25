variable "subscription_id" {
    default = ""
}

variable "resource_group_name" {
    default = ""
}

variable "location" {
    default = ""
}

variable "client_id" {
  description = "The Client ID of the Azure Service Principal"
  type        = string
}

variable "client_secret" {
  description = "The Client Secret of the Azure Service Principal"
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for the Azure Subscription"
  type        = string
}