module "bux-hw" {
  source = "github.com/jaralonzo/bux-hw.git"

  name     = "cloudrun-srv"
  location = "europe-west4"
  project  = "bux-hw"

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

# data "google_iam_policy" "this" {
#   binding {
#     role = "roles/run.invoker"
#     members = [
#       "allUsers",
#     ]
#   }
# }

resource "google_cloud_run_service_iam_binding" "this" {
  service  = module.bux-hw.name
  location = module.bux-hw.location
  project = module.bux-hw.project
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}

# resource "google_cloud_run_service_iam_policy" "noauth" {
#   service     = module.bux-hw.name
#   location    = module.bux-hw.location
#   project     = module.bux-hw.project
#   policy_data = google_cloud_run_service_iam_binding.default.policy_data
#   # policy_data = data.google_iam_policy.noauth.policy_data
# }
