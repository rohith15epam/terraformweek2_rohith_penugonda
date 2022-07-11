resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       =  google_compute_network.vpc.id
}
resource "google_sql_database_instance" "instance" {
    name             = "cloud-sql-instance109"
    region           = "us-central1"
    database_version = "MYSQL_5_7"
    depends_on = [google_service_networking_connection.private_vpc_connection]
    settings {
        tier = "db-f1-micro"
        ip_configuration {
            ipv4_enabled    = false
            private_network =  google_compute_network.vpc.id
        }
    }
}
resource "google_sql_user" "users" {
    name     = "root"
    password = "rohith12345"
    instance = google_sql_database_instance.instance.name
}
resource "google_sql_database" "database" {
  name     = "my-database1"
  instance = google_sql_database_instance.instance.name
}
resource "google_storage_bucket" "default" {
  name          = "mybucket-image1"
  location      = "US"
  force_destroy = true
}