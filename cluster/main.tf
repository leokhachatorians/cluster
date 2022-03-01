terraform {

  required_version = "1.1.2"

  backend "gcs" {
    bucket = "tf-state-bucket-leo"
    prefix = "cluster"
    credentials = "../config/tf-gke-cluster-key.json"
  }

  required_providers {
    google = {
      version = "4.11.0"
    }

  }
}

provider "google" {
  credentials = file(var.creds)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_container_cluster" "cluster" {
  name     = "${var.project_id}-gke-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "node_pool" {
  name       = "${google_container_cluster.cluster.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.cluster.name
  node_count = 1

  node_config {
    preemptible = false
    machine_type = "e2-micro"

    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

}
