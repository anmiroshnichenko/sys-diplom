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
    nat       = false
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
  }
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
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
  }
}




# Creating a VM_Elasticsearch

resource "yandex_compute_instance" "elasticsearch" {

  name        = "elasticsearch"
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
    nat       = false
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
  }
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
  }

  metadata = {
    user-data = "${file("./meta-monitoring.yaml")}"
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
#resource "yandex_vpc_subnet" "subnet-2" {
#   name           = "subnet2"
#   zone           = var.zone1
#   v4_cidr_blocks = ["192.168.20.0/24"]
#   network_id     = "${yandex_vpc_network.network-1.id}"
#}