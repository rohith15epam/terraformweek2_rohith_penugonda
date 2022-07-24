output "vpc-id" {
  value = google_compute_network.vpc.id
}

output "subnetid" {
  value = google_compute_subnetwork.subnet.id
}