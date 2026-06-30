variable "vm_count" {
  description = "Number of virtual machines to provision."
  type        = number

  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 5
    error_message = "vm_count must be between 1 and 5."
  }
}

variable "vm_imageid" {
  description = "Azure Compute Gallery image definition ID used as the VM source image."
  type        = string
}

variable "vm_size" {
  description = "Azure VM SKU size (small | middle | large)."
  type        = string

  validation {
    condition     = contains(["small", "middle", "large"], lower(var.vm_size))
    error_message = "vm_size must be one of: small, middle, large."
  }
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "East US"
}

variable "vm_os" {
  description = "Target operating system."
  type        = string
  default     = "linux"
}

variable "request_id" {
  description = "Unique request identifier passed from the dispatch payload."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.request_id))
    error_message = "request_id must contain only alphanumeric characters, hyphens, and underscores."
  }
}

