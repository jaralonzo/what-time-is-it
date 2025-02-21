module "bux-hw" {
  source = "github.com/jaralonzo/bux-hw.git"
  name       = "cloudrun-srv"
  location   = "europe-west4"

  traffic = {
    percent         = 100
    latest_revision = true
  }

  template = {
    spec = {
      containers = {
        image = "europe-west4-docker.pkg.dev/bux-hw/bux-hw/what-time-is-it:latest"
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}