terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = ""
  cloud_id  = "b1gkpecqu2tuq6ju977b"
  folder_id = "b1g7m1f0du99jio1nr2o"
  zone      = var.zone
}
