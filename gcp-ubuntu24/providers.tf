terraform {
  required_version = ">= 0.14.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.50.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1.2"
    }
  }
}

provider "google" {
  credentials = file(var.srvc_acct_file)
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
