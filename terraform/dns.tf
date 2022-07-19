data "google_dns_managed_zone" "this" {
  provider = google.dns

  name = "dogar-dev"
}

resource "google_dns_record_set" "this" {
  provider = google.dns

  name = "action-runner.${data.google_dns_managed_zone.this.dns_name}"
  type = "A"
  ttl = 60

  managed_zone = data.google_dns_managed_zone.this.name

  rrdatas = [google_compute_instance.this.network_interface[0].access_config[0].nat_ip]
}
