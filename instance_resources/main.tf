resource "google_service_account" "service_account" {
  account_id   = "service-account0001"
  display_name = "service account"
}
resource "google_project_iam_binding" "log_user" {
  role    = "roles/editor"
  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
resource "google_compute_instance_template" "default" {
  name        = "instance-template1"
  description = "This template is used to create app server instances."
  tags = ["allow-health-check"]
machine_type         = "e2-medium"
service_account {
    email  = google_service_account.service_account.email
    scopes = ["cloud-platform"]
  }
disk {
    source_image      = "debian-cloud/debian-9"
    auto_delete       = true
    boot              = true
}
network_interface {
    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id
  }
  metadata_startup_script = file("${path.module}/startup-script.sh")
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    request_path = "/_ah/health"
    port         = "8080"
  }
  }
resource "google_compute_instance_group_manager" "default" {
  name = "instance-group1"
  base_instance_name = "app"
  zone               = "us-central1-a"
  version {
    instance_template  = google_compute_instance_template.default.id
  }
  target_size  = 1
  named_port {
    name = "http"
    port = 8080
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}
resource "google_compute_firewall" "rule" {
  priority     = 1000
  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  name = "firewall-rule1"
  network                 =  google_compute_network.vpc.id
  allow {
    protocol = "tcp"
    ports  = ["8080"]
  }
    target_tags = ["allow-health-check"]
}
resource "google_compute_firewall" "http" {
  priority     = 1000
  source_ranges = ["0.0.0.0/0"]
  name = "firewall-rule2"
  network                 =  google_compute_network.vpc.id
  allow {
    protocol = "tcp"
    ports  = ["8080"]
  }
    target_tags = ["http-server"]
    }
resource "google_compute_global_forwarding_rule" "my-forwarding-rule" {
  name = "forwarding-rule-global"
  target                = google_compute_target_http_proxy.default.id
  port_range            = "80"
   load_balancing_scheme = "EXTERNAL"
}
resource "google_compute_target_http_proxy" "default" {
  name    = "test-proxy"
  url_map = google_compute_url_map.default.id
}
resource "google_compute_url_map" "default" {
  name            = "load-balancer"
  default_service = google_compute_backend_service.default.id
}
resource "google_compute_backend_service" "default" {
  name                  = "backend-service"
  protocol              = "HTTP"
  timeout_sec           = 10
  load_balancing_scheme = "EXTERNAL"
  health_checks = [google_compute_health_check.autohealing.id]
  backend {
    group           = google_compute_instance_group_manager.default.instance_group
}
}
resource "google_compute_autoscaler" "default" {
  name   = "my-autoscaler"
  zone   = "us-central1-a"
  target = google_compute_instance_group_manager.default.id
  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 60
    cpu_utilization {
      target = 0.5
      }
  }
}