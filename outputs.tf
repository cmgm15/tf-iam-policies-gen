output "policies_json" {
  description = "Object with the JSON of the generated IAM policies."
  value = tomap({
    for k, value in data.aws_iam_policy_document.this : k => value.json
  })
}