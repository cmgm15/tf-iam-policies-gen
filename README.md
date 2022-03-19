# tf-iam-policies-gen

## Example of use

```
module "sso_inline_policy_generator" {
    source = "./"

    permissions = [
    {
      name       = "developers"
      statements = [
        {
          effect    = "Allow"
          actions   = [
              "rds:*",
              "ecs:*"
          ]
          resources = concat([
              data.terraform_remote_state.rds.outputs.cluster_arn,
            ],
            data.terraform_remote_state.lb.outputs.alb_private_arns
          )
        },
        {
          effect    = "Deny"
          actions   = [
            "s3:*",
          ]
          resources = [
            aws_s3_bucket.test.arn
          ]
        }
      ]
    },
    {
      name       = "qa"
      statements = [
        {
          effect    = "Allow"
          actions   = [
            "s3:List*",
            "s3:Get*",
          ]
          resources = [
            aws_s3_bucket.test.arn
          ]
        }
      ]
    }
  ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_permissions"></a> [permissions](#input\_permissions) | List of policies that you want to create with the IAM Policy format. Defaults to empty list. | <pre>set(object({<br>    name       = string<br>    statements = set(object({<br>      sid      = string<br>      effect    = string<br>      actions   = set(string)<br>      resources = set(string)<br>      condition = set(object({<br>          test = string<br>          variable = string<br>          values = set(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policies_json"></a> [policies\_json](#output\_policies\_json) | Object with the JSON of the generated IAM policies. |
<!-- END_TF_DOCS -->