 resource "google_compute_global_address" "private_ip_address" {
    name          = var.privateipname
    purpose       = var.privateippurpose
    address_type  = var.privateipaddress
    prefix_length = var.privateprefix
    network       = var.network-id
  }
  resource "google_service_networking_connection" "private_vpc_connection" {
  network                 =  var.network-id
  service                 = var.connectionservice
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
resource "google_sql_database_instance" "dbinstance" {
    name             = var.sqlname
    region           = var.sqlregion
    database_version = var.sqlversion
    depends_on = [google_service_networking_connection.private_vpc_connection]
    settings {
        tier = var.sqltier
        ip_configuration {
            ipv4_enabled    = var.sqlip
            private_network =  var.network-id
        }
    }
}
resource "google_sql_user" "users" {
    name     = var.sqluser
    password = var.sqlpass
    instance = google_sql_database_instance.dbinstance.name
}
resource "google_sql_database" "database" {
  name     = var.sqldb
  instance = google_sql_database_instance.dbinstance.name
}
resource "google_storage_bucket" "bucketimage" {
  name          = var.bucketname
  location      = var.bucketloc
  force_destroy = var.bucketforce
}
resource "google_storage_default_object_access_control" "bucketrule" {
  bucket = google_storage_bucket.bucketimage.name
  role   = var.bucketrole
  entity = var.bucketentity
}