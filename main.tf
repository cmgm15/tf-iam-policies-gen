data "aws_iam_policy_document" "this" {
  for_each = { for permission in var.permissions : permission.name => permission}
  
  dynamic statement {
    for_each = each.value.statements
    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
      
      dynamic "condition" {
        for_each = statement.value.condition
        content {
          test = condition.value.test
          variable = condition.value.variable
          values = condition.value.values
        } 
      }
    }
  }
}
