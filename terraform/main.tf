terraform {
  backend "local" {
    path = "/state/terraform.tfstate"
  }
}

variable "host" {}

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
    organization = var.host
  }
}

resource "cloudflare_origin_ca_certificate" "ca" {
  csr                = tls_cert_request.ca.cert_request_pem
  hostnames          = [ var.host, "www.${var.host}" ]
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

resource "null_resource" "cloudflare_certificate" {
  provisioner "local-exec" {
    command = "wget -O /certificate/origin-pull-ca.pem https://support.cloudflare.com/hc/en-us/article_attachments/360044928032/origin-pull-ca.pem"
  }
}
