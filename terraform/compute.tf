resource "google_compute_instance" "this" {
  name = var.name
  machine_type = "f1-micro"
  allow_stopping_for_update = true
  tags = ["github"]

  labels = {
    "env" = "github"
  }

  metadata = {
    ssh-keys = "shahab96:${file("../id_rsa.pub")}"
  }

  network_interface {
    network = google_compute_network.this.id

    access_config {
      network_tier = "STANDARD"
      nat_ip = google_compute_network.this.gateway_ipv4
    }
  }

  metadata_startup_script = file("../init")

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 20
    }
  }
}

resource "google_compute_firewall" "this" {
  name = var.name
  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["github"]
}