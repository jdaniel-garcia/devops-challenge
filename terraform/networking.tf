resource "google_compute_network" "vpc" {
  name                    = "moonpay-vpc"
  auto_create_subnetworks = false

  depends_on = [google_project_service.enabled_apis]
}

resource "google_compute_subnetwork" "subnet" {
  name          = "moonpay-subnet"
  region        = var.google_region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.11.0.0/16"
  }
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.12.0.0/20"
  }
}