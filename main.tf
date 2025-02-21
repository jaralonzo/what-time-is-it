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
