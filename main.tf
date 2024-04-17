data "aws_caller_identity" "current" {
}

locals {
  account_id          = data.aws_caller_identity.current.account_id
  issuer_host_path    = trim(var.issuer_url, "https://")
  provider_arn        = "arn:aws:iam::${local.account_id}:oidc-provider/${local.issuer_host_path}"
  service_account     = var.service_account == "" ? "external-dns" : var.service_account
  service_account_arn = "system:serviceaccount:${var.kubernetes_namespace}:${local.service_account}"
}

data "aws_iam_policy_document" "oidc_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [local.provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.issuer_host_path}:sub"
      values   = [local.service_account_arn]
    }
  }
}

data "aws_iam_policy_document" "route53_access" {
  statement {
    sid    = "Route53UpdateZones"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = var.allowed_zones
  }

  statement {
    sid    = "Route53ListZones"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "route53_access" {
  name        = "eks-${var.cluster_name}-external-dns-route53-access"
  description = "EKS - Route53 access for external-dns service ($var.cluster_name)"
  path        = "/"
  policy      = data.aws_iam_policy_document.route53_access.json
}

resource "aws_iam_role" "external_dns" {
  name               = "eks-${var.cluster_name}-external-dns"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume.json
  path               = "/"
}

resource "aws_iam_role_policy_attachment" "route53_access" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.route53_access.arn
}
