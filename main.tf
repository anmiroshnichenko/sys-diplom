terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}


provider "yandex" {
  token     = "y0_AgAAAABQ9we7AATuwQAAAADeMZhKaL65l4k1R4C7lQ5xx15m6PUrmjk"
  cloud_id  = "b1gkpecqu2tuq6ju977b"
  folder_id = "b1g7m1f0du99jio1nr2o"
  zone      = var.zone
}

resource "yandex_compute_instance" "vm-1" {

  name        = "terraform1"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8a67rb91j689dqp60h"
      size = "5"	
    }
  }

  network_interface {
#    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"	

  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = var.zone
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.network-1.id}"
}
