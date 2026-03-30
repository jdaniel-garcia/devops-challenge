module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 44.0"

  project_id = var.google_project_id
  name       = "moonpay-cluster"

  region     = var.google_region
  regional   = false
  zones      = ["${var.google_region}-a"]

  network           = google_compute_network.vpc.name
  subnetwork        = google_compute_subnetwork.subnet.name
  ip_range_pods     = "pods-range"
  ip_range_services = "services-range"

  deletion_protection = false

  remove_default_node_pool = true

  node_pools = [
    {
      name               = "default"
      machine_type       = "e2-standard-2"
      min_count          = 1
      max_count          = 1
      local_ssd_count    = 0
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      initial_node_count = 1
    }
  ]
}