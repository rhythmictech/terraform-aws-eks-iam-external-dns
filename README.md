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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allowed\_zones | List of zones this service account is permitted to update \(in ARN format\) | list(string) | `[ "arn:aws:route53:::hostedzone/*" ]` | no |
| cluster\_name |  | string | n/a | yes |
| issuer\_url | OIDC issuer URL \(include prefix\) | string | n/a | yes |
| kubernetes\_namespace | Namespace to operate in \(service accounts and pods must be in the same namespace\) | string | `"default"` | no |
| service\_account | Name of service account to create \(computed based on cluster name if not specified\) | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_external\_dns\_arn |  |
| service\_account |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
