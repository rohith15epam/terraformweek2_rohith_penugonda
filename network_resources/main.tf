resource "google_compute_network" "vpc" {
    name                 = var.vpc-name
    auto_create_subnetworks = var.vpc-auto
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet-name
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.subnet-ip
  region        = var.subnet-region
}

resource "google_compute_router" "router" {
  name                          = var.router-name
  region                        = google_compute_subnetwork.subnet.region
  network                       = google_compute_network.vpc.id
    bgp {
      asn               = var.router-asn
    }
  }

  resource "google_compute_router_nat" "nat" {
  name                               = var.nat-name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = var.nat-ip
  source_subnetwork_ip_ranges_to_nat = var.natsource
  }
 
