terraform {
  backend "gcs" {
    bucket = "terraform-state-fzaspcp1"
    prefix = "github-runner"
  }
  required_version = ">= 1.2.4"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.28.0"
    }
  }
}

provider "google" {
  project = data.terraform_remote_state.infra.outputs.projects.github-runner
  region = "us-west1"
  zone = "us-west1-a"
}

provider "google" {
  project = data.terraform_remote_state.infra.outputs.projects.dogar
  alias = "dns"
}

data "terraform_remote_state" "infra" {
  backend = "gcs"
  
  config = {
    bucket = "terraform-state-fzaspcp1"
  }
}
