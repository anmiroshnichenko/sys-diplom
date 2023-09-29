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
    security_group_ids = [yandex_vpc_security_group.sg-web.id]
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"	
  }

  # scheduling_policy {
  #   preemptible = true
  # }
}

# # Creating a VM_2
resource "yandex_compute_instance" "vm-2" {

  name        = "linux-vm2"
  allow_stopping_for_update = true
  platform_id = "standard-v2"
  zone        = var.zone1
  # zone        = var.zone

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
    security_group_ids = [yandex_vpc_security_group.sg-web.id]
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }

  # scheduling_policy {
  #   preemptible = true
  # }
}

# Creating a VM_Prometheus

resource "yandex_compute_instance" "prometheus" {

  name        = "prometheus"
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
      image_id = var.image_id
      size = "5"	
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.sg-monitoring.id]
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
  }

  # scheduling_policy {
  #   preemptible = true
  # }
}

# Creating a VM_Grafana

resource "yandex_compute_instance" "grafana" {

  name        = "grafana"
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
      image_id = var.image_id
      size = "5"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.sg-dashboard.id]
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
  }

  # scheduling_policy {
  #   preemptible = true
  # }
}

# # Creating a VM_Elasticsearch

resource "yandex_compute_instance" "elasticsearch" {

  name        = "elasticsearch"
  allow_stopping_for_update = true
  platform_id = "standard-v2"
  zone        = var.zone

  resources {
    core_fraction = 20
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = "5"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.sg-elk.id]
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
  }

  # scheduling_policy {
  #   preemptible = true
  # }
}

# Creating a VM_Kibana
resource "yandex_compute_instance" "kibana" {

  name        = "kibana"
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
      image_id = var.image_id
      size = "5"	
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.sg-dashboard.id, yandex_vpc_security_group.sg-bastion.id]
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
  }

  # scheduling_policy {
  #   preemptible = true
  # }
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

 

