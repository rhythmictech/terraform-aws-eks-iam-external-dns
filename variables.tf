variable "allowed_zones" {
  default     = ["arn:aws:route53:::hostedzone/*"]
  description = "List of zones this service account is permitted to update (in ARN format)"
  type        = list(string)
}

variable "cluster_name" {
  type = string
}

variable "issuer_url" {
  description = "OIDC issuer URL (include prefix)"
  type        = string
}

variable "kubernetes_namespace" {
  default     = "default"
  description = "Namespace to operate in (service accounts and pods must be in the same namespace)"
  type        = string
}

variable "service_account" {
  default     = ""
  description = "Name of service account to create (computed based on cluster name if not specified)"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to add to supported resources"
  type        = map(string)
}
