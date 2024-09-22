locals {
  full_domain_name = var.subdomain != "" ? "${var.subdomain}.${var.root_domain}" : var.root_domain
}

variable "root_domain" {
  description = "Root domain name for the website"
  type        = string
}

variable "subdomain" {
  description = "Subdomain name for the website (if any)"
  type        = string
  default     = ""
}
