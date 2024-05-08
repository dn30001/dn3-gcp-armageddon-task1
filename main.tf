
resource "google_storage_bucket" "GCS1" {
  name = "dn3-bucket-section-5-30-tf"
  storage_class = "NEARLINE"
  location =  "US-CENTRAL1"
  labels = {
    "env" = "tf_env"
    "dep" = "complience"
  }

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"  
    not_found_page = "404.html"
    }

  lifecycle_rule {
    condition {
      age = 5
  }
    action {
      type = "SetStorageClass"
      storage_class = "COLDLINE"
      
  }

  }

}

resource "google_storage_bucket_object" "mp3" {
  name = "rap_song"
  bucket = google_storage_bucket.GCS1.name
  source = "Cloud_Surfing.mp3"
}

output "website_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.GCS1.name}/index.html"
}
