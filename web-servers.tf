# Adding a ready-made VM image

#resource "yandex_compute_image" "lemp-vm-image" {
#  source_family = var.vm_image_family
#}

#data "yandex_compute_image" "base_image" {
#  family = var.yc_image_family
#}


# Creating a VM_1
resource "yandex_compute_instance" "vm-1" {

  name        = "linux-vm1"
  allow_stopping_for_update = true
  platform_id = "standard-v2"
  zone        = var.zone

  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      #image_id = "${yandex_compute_image.lemp-vm-image.id}"
      image_id = var.image_id
      size = "5"	
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"	

  }
}

# Creating a VM_2
resource "yandex_compute_instance" "vm-2" {

  name        = "linux-vm2"
  allow_stopping_for_update = true
  platform_id = "standard-v2"
  zone        = var.zone1

  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      #image_id = "${yandex_compute_image.lemp-vm-image.id}"
      image_id = var.image_id
      size = "5"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-2.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}
# Creating a cloud network

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

# Creating a subnet

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = var.zone
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.network-1.id}"
}
resource "yandex_vpc_subnet" "subnet-2" {
   name           = "subnet2"
   zone           = var.zone1
   v4_cidr_blocks = ["192.168.20.0/24"]
   network_id     = "${yandex_vpc_network.network-1.id}"
}