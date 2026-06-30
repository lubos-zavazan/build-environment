variable "vm_count" {
  description = "Number of virtual machines to provision."
  type        = number
}

variable "vm_imageid" {
  description = "Azure Compute Gallery image definition ID used as the VM source image."
  type        = string
}

variable "vm_size" {
  description = "Azure VM SKU size (small | middle | large)."
  type        = string
}

variable "vm_os" {
  description = "Target operating system."
  type        = string
  default     = "linux"
}

variable "request_id" {
  description = "Unique request identifier passed from the dispatch payload."
  type        = string
}

variable "azure_image_id" {
  description = "Fully resolved Azure resource ID of the image definition."
  type        = string
}
