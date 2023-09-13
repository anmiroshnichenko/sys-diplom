terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "y0_AgAAAABQ9we7AATuwQAAAADeMZhKaL65l4k1R4C7lQ5xx15m6PUrmjk"
  cloud_id  = "b1gkpecqu2tuq6ju977b"
  folder_id = "b1g7m1f0du99jio1nr2o"
  zone      = var.zone
}
