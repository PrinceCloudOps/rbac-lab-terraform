variable "resource_group_name" {
  type        = string
  description = "Resource group where Lab 1 resources are deployed"
  default     = "RG-Hybrid-Identity-Lab"
}

variable "vm_name" {
  type        = string
  description = "Target File Server VM name for scoped RBAC"
  default     = "FS01"
}

variable "sysadmin_object_id" {
  type        = string
  description = "Object ID of the SysAdmin user (Owner role)"
}

variable "support_object_id" {
  type        = string
  description = "Object ID of the Support user (VM Contributor role)"
}

variable "auditor_object_id" {
  type        = string
  description = "Object ID of the Auditor user (Reader role)"
}
