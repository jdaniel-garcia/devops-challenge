terraform {
  required_version = ">= 1.14"

  backend "gcs" {
    bucket  = "tech-challenge-moonpay-tfstate"
    prefix  = "terraform-state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.google_project_id
  region  = var.google_region
}