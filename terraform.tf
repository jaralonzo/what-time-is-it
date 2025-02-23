provider "google" {
  project     = "bux-hw"
  region      = "europe-west4"
}

terraform {
  backend "gcs" {
    bucket  = "bux-hw_cloudbuild"
    prefix  = "source"
  }
}