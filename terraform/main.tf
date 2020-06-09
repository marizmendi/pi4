terraform {
  backend "local" {
    path = "/state/terraform.tfstate"
  }
}

variable "domain" {}

provider "cloudflare" {
  version = "~> 2.0"
}

# Create a CSR and generate a CA certificate
resource "tls_private_key" "ca" {
  algorithm = "RSA"
}

resource "tls_cert_request" "ca" {
  key_algorithm   = tls_private_key.ca.algorithm
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name  = ""
    organization = var.domain
  }
}

resource "cloudflare_origin_ca_certificate" "ca" {
  csr                = tls_cert_request.ca.cert_request_pem
  hostnames          = [ var.domain, "www.${var.domain}" ]
  request_type       = "origin-rsa"
  requested_validity = 365
}

resource "local_file" "private_key" {
    content     = tls_private_key.ca.private_key_pem
    filename = "/certificate/privkey.pem"
    file_permission = "0400"
}

resource "local_file" "certificate" {
    content     = cloudflare_origin_ca_certificate.ca.certificate
    filename = "/certificate/certificate.pem"
    file_permission = "0444"
}
