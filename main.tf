module "bux-hw" {
  source = "github.com/jaralonzo/bux-hw.git"

  name                       = "what-time-is-it"
  location                   = "europe-west4"
  project                    = "bux-hw"
  autogenerate_revision_name = true

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

  # Cloud Armour
  security_policy_name        = "my-policy"
  security_policy_description = "basic security policy"
  security_policy_type        = "CLOUD_ARMOR"
  rule = [{
    action   = "allow"
    priority = "1000"
    match = {
      versioned_expr = "SRC_IPS_V1"
      config = {
         src_ip_ranges = ["0.0.0.0/0"]
      }
    }
    description = "Allow traffic."
    },
    {
    action   = "allow"
    priority = "2147483647"
    match = {
      versioned_expr = "SRC_IPS_V1"
      config = {
         src_ip_ranges = ["*"]
      }
    }
    description = "Allow traffic."
    }]
}

data "google_iam_policy" "this" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "this" {
  service     = module.bux-hw.name
  location    = module.bux-hw.location
  project     = module.bux-hw.project
  policy_data = data.google_iam_policy.this.policy_data
}

