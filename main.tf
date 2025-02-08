provider "google" {
    project = var.project_id
    region = var.region
    impersonate_service_account = var.impersonate_service_account
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-gcp-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral external IP
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "tf-state-intense-elysium-446714-g4"
    prefix = "terraform/state"
  }
}