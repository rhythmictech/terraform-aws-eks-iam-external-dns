output "iam_role_external_dns_arn" {
  value = aws_iam_role.external_dns.arn
}

output "service_account" {
  value = local.service_account
}
