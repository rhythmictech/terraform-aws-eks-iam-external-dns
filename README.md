# terraform-aws-eks-iam-external-dns
[![](https://github.com/rhythmictech/terraform-aws-eks-iam-external-dns/workflows/check/badge.svg)](https://github.com/rhythmictech/terraform-aws-eks-iam-external-dns/actions)

Configure IAM role and related policies to use EKS Service Accounts with the external-dns service.

## Usage
```
module "external_dns" {
  source               = "git::https://github.com/rhythmictech/terraform-aws-eks-iam-external-dns"
  cluster_name         = module.eks.cluster_name
  issuer_url           = module.eks.cluster_issuer_url
  kubernetes_namespace = "kube-system"
}


```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.20 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.route53_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.route53_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.oidc_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.route53_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_issuer_url"></a> [issuer\_url](#input\_issuer\_url) | OIDC issuer URL (include prefix) | `string` | n/a | yes |
| <a name="input_allowed_zones"></a> [allowed\_zones](#input\_allowed\_zones) | List of zones this service account is permitted to update (in ARN format) | `list(string)` | <pre>[<br>  "arn:aws:route53:::hostedzone/*"<br>]</pre> | no |
| <a name="input_kubernetes_namespace"></a> [kubernetes\_namespace](#input\_kubernetes\_namespace) | Namespace to operate in (service accounts and pods must be in the same namespace) | `string` | `"default"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Name of service account to create (computed based on cluster name if not specified) | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to supported resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_external_dns_arn"></a> [iam\_role\_external\_dns\_arn](#output\_iam\_role\_external\_dns\_arn) | n/a |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
