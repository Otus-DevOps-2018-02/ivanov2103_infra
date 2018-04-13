resource "google_compute_instance_group" "app-group" {
  name = "reddit-app-group"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  zone = "${var.zone}"

  named_port {
    name = "http"
    port = "9292"
  }
}

resource "google_compute_http_health_check" "app-hcheck" {
  name               = "reddit-app-hcheck"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
  port               = "9292"
}

resource "google_compute_backend_service" "app-lb-backend" {
  name        = "reddit-app-lb-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = "${google_compute_instance_group.app-group.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.app-hcheck.self_link}"]
}

resource "google_compute_global_forwarding_rule" "app-lb-fwrule" {
  name       = "reddit-app-lb-fwrule"
  target     = "${google_compute_target_http_proxy.app-lb-proxy.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "app-lb-proxy" {
  name    = "reddit-app-lb-proxy"
  url_map = "${google_compute_url_map.app-lb-map-rule.self_link}"
}

resource "google_compute_url_map" "app-lb-map-rule" {
  name            = "reddit-app-lb-map-rule"
  default_service = "${google_compute_backend_service.app-lb-backend.self_link}"
}
