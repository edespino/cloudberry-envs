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
  credentials = file(var.SRVC_ACCT_FILE)
  project     = var.GCP_PROJECT
  region      = var.GCP_REGION
  zone        = var.GCP_ZONE
}
