resource "google_compute_network" "vpc" {
    name                 = "bookshelf-week2-vpc"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "bookshelf-subnetwork"
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
}

resource "google_compute_router" "router" {
  name                          = "bookshelf-router"
  region                        = google_compute_subnetwork.subnet.region
  network                       = google_compute_network.vpc.id
  }

  resource "google_compute_router_nat" "nat" {
  name                               = "bookshelf-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
