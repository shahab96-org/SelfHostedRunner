resource "google_compute_network" "this" {
  name = var.name
  auto_create_subnetworks = true
  routing_mode = "REGIONAL"
}
