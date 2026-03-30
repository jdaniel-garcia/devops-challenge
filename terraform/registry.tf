resource "google_artifact_registry_repository" "challenge_moonpay" {
  location      = "europe-southwest1"
  repository_id = "challenge-moonpay"
  description   = "Docker repository for MoonPay Challenge"
  format        = "DOCKER"
  docker_config {
    immutable_tags = true
  }
}
