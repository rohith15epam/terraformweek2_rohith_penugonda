terraform {
    required_providers {
            google = {
                source = "hashicorp/google"
                version = "3.20.0"
        }
    }
}
backend "gcs" {
  bucket  = "tf-bookshelf-penugonda1"
  prefix  = "terraform/state"
}
provider "google" {
  project = "gcp-terraform-phase2-penugonda"

  region = "us-central1"
  zone   = "us-central1-c"
}
module "network_resources" {
  source = "C:/Users/Rohith_Penugonda/Desktop/bookshelf_week2/network_resources/main.tf"
  
}