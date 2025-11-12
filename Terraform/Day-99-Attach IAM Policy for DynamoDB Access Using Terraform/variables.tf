variable KKE_TABLE_NAME {
  type        = string
  default     = "datacenter-table"
  description = "Dynamodb name"
}

variable KKE_POLICY_NAME {
  type        = string
  default     = "datacenter-readonly-policy"
  description = "Iam readonly policy for datacenter"
}

variable KKE_ROLE_NAME {
  type        = string
  default     = "datacenter-role"
  description = "Iam Role Name"
}