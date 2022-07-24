resource "google_service_account" "serviceaccount" {
  account_id   = var.serviceid
  display_name = var.servicename
}
resource "google_project_iam_member" "iamuser" {
  role = var.iamrole
  member = "serviceAccount:${google_service_account.serviceaccount.email}"
}
resource "google_compute_instance_template" "template1" {
  name         = var.templatename
  tags         = [var.tagname]
  machine_type = var.templatetype
  service_account {
    email  = google_service_account.serviceaccount.email
    scopes = var.scopename
  }
  disk {
    source_image = var.disktype
    auto_delete  = var.autodelete
    boot         = var.boot
  }
  network_interface {
    network    = var.network-id
    subnetwork = var.subnet_id
  }
  metadata_startup_script = file("${path.module}/startup-script.sh")
}

resource "google_compute_health_check" "health1" {
  name                = var.healthcheckname
  http_health_check {
    port         = var.tagforhealthcheck
    request_path = var.requestpath
  }
}
resource "google_compute_instance_group_manager" "grp" {
  name               = var.groupname
  base_instance_name = var.instancebasename
  zone               = var.groupzone
  version {
    instance_template = google_compute_instance_template.template1.id
  }
  named_port {
    name = var.groupnamedportname
    port = var.groupnamedportport
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.health1.id
    initial_delay_sec = var.groupinitaldelay
  }
}
resource "google_compute_autoscaler" "auto1" {
  name   = var.autoscalename
  zone   = var.autoscalezone
  target = google_compute_instance_group_manager.grp.id
  autoscaling_policy {
    max_replicas    = var.maxreplica
    min_replicas    = var.minreplica
    cooldown_period = var.cooldownperiod
  }
}
resource "google_compute_firewall" "rule" {
  source_ranges = var.rulerange
  name          = var.rulename
  network       = var.network-id
  allow {
    protocol = var.ruleprotocol
    ports    = var.ruleport
  }
  target_tags = var.ruletarget
}
resource "google_compute_firewall" "rule2" {
  source_ranges = var.rulerange1
  name    = var.rulename1
  network = var.network-id
  allow {
    protocol = var.ruleprotocol1
    ports    =  var.ruleport1
  }
}
resource "google_compute_global_forwarding_rule" "forwarding-rule" {
  name                  = var.firewallrulename
  target                = google_compute_target_http_proxy.proxy1.id
  port_range            = var.firewallport
  load_balancing_scheme = var.firewallschema
}
resource "google_compute_target_http_proxy" "proxy1" {
  name    = var.proxynamefirewall
  url_map = google_compute_url_map.lb.id
}
resource "google_compute_url_map" "lb" {
  name            = var.loadbalancername
  default_service = google_compute_backend_service.backend1.id
}
resource "google_compute_backend_service" "backend1" {
  name                  = var.backendname
  protocol              = var.backendprotocol
  timeout_sec           = var.backendtimeout
  load_balancing_scheme = var.backendschema
  port_name = var.backendportname
  health_checks         = [google_compute_health_check.health1.id]
  backend {
    group = google_compute_instance_group_manager.grp.instance_group
  }
}
