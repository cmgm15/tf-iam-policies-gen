variable "permissions" {
  type = set(object({
    name       = string
    statements = set(object({
      sid      = string
      effect    = string
      actions   = set(string)
      resources = set(string)
      condition = set(object({
          test = string
          variable = string
          values = set(string)
      }))
    }))
  }))
  description = "List of policies that you want to create with the IAM Policy format. Defaults to empty list."
  default     = []
}
