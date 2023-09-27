#Creating a securite groups
resource "yandex_vpc_security_group" "sg-bastion" {
  name        = "sg-bastion"
  description = "allows connecting to bastion only from whitelisted address"
  network_id  = "${yandex_vpc_network.network-1.id}"
  
  labels = {
     type = "sg-bastion"
   }

  ingress {
    protocol       = "TCP"
    description    = "allow-ssh-from-trusted-ip"
    v4_cidr_blocks = var.bastion_whitelist_ip
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "allow-icmp-from-trusted-ip"
    v4_cidr_blocks = var.bastion_whitelist_ip
  }

  # egress {
  #   protocol       = "ANY"
  #   #description    = "we allow any egress, since we block on ingress"
  #   v4_cidr_blocks = ["0.0.0.0/0"]
  # }
}

#Creating a securite groups  sg-web

resource "yandex_vpc_security_group" "sg-web" {
  name        = "sg-web"
  #description = "description for my security group"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    description    = "allows remote access only through Bastion"
    security_group_id  = yandex_vpc_security_group.sg-bastion.id
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "allows ping only from bastion"
    security_group_id  = yandex_vpc_security_group.sg-bastion.id
  }

  ingress {
    protocol       = "TCP"
    description    = "allows remote access alb"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
    #security_group_id  = yandex_vpc_security_group.sg-ci-cd.id
    port      = 80
  } 

  ingress {
    protocol       = "TCP"
    description    = "allows access nginx_log_exporter"
    v4_cidr_blocks = ["192.168.10.0/24"]
    #security_group_id  = yandex_vpc_security_group.sg-ci-cd.id
    port      = 4040
  } 

  ingress {
    protocol       = "TCP"
    description    = "allows remote access node_exporter"
    v4_cidr_blocks = ["192.168.10.0/24"]
    #security_group_id  = yandex_vpc_security_group.sg-ci-cd.id
    port      = 9100
  }

  egress {
    protocol       = "TCP"
    description    = "allows access filebeat "
    v4_cidr_blocks = ["192.168.10.0/24"]
    port      = 5044
  }
}  
  
  # egress {
  #   protocol       = "TCP"
  #   description    = "Rule description 2"
  #   v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  #   port      = 4040
  # }

  
#Creating a securite groups  sg-monitoring

resource "yandex_vpc_security_group" "sg-monitoring" {
  name        = "sg-monitoring"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    description    = "allows remote access only through Bastion"
    security_group_id  = yandex_vpc_security_group.sg-bastion.id
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "allows access grafana"
    v4_cidr_blocks = ["192.168.10.0/24"]
    #v4_cidr_blocks = var.bastion_whitelist_ip
    port           = 9090
  }

  egress {
    protocol       = "TCP"
    description    = "allows access nginx_log_exporter"
    #v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
    security_group_id  = yandex_vpc_security_group.sg-web.id
    port      = 4040
  } 

  egress {
    protocol       = "TCP"
    description    = "allows remote access node_exporter"
    #v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
    security_group_id  = yandex_vpc_security_group.sg-web.id
    port      = 9100
  }
}

#Creating a securite groups  sg-dashboard

resource "yandex_vpc_security_group" "sg-dashboard" {
  name        = "sg-dashboard"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    description    = "allows remote access only through Bastion"
    security_group_id  = yandex_vpc_security_group.sg-bastion.id
    port           = 22
  }
 
 ingress {
    protocol       = "TCP"
    description    = "allow-from-trusted-ip"
    v4_cidr_blocks = var.bastion_whitelist_ip
    port           = 3000
  }

  ingress {
    protocol       = "TCP"
    description    = "allow-from-trusted-ip"
    v4_cidr_blocks = var.bastion_whitelist_ip
    port           = 5601
  }

  egress {
    protocol       = "TCP"
    description    = "allows access grafana"
    #v4_cidr_blocks = ["192.168.10.0/24"]
    security_group_id  = yandex_vpc_security_group.sg-monitoring.id
    port           = 9090
  }

  egress {
    protocol       = "TCP"
    description    = "allows access kibana"
    #v4_cidr_blocks = ["192.168.10.0/24"]
    security_group_id  = yandex_vpc_security_group.sg-elk.id
    port           = 9200
  }
}

#Creating a securite groups  sg-ELK

resource "yandex_vpc_security_group" "sg-elk" {
  name        = "sg-elk"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    description    = "allows remote access only through Bastion"
    security_group_id  = yandex_vpc_security_group.sg-bastion.id
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "allows access kibana"
    v4_cidr_blocks = ["192.168.10.0/24"]
    #security_group_id  = yandex_vpc_security_group.sg-dashboard.id
    port           = 9200
  }

  egress {
    protocol       = "TCP"
    description    = "allows access logstash"
    v4_cidr_blocks = ["192.168.10.0/24"]
    #security_group_id  = yandex_vpc_security_group.sg-dashboard.id
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "allows access filebeat "
    #v4_cidr_blocks = ["192.168.10.0/24"]
    security_group_id  = yandex_vpc_security_group.sg-web.id
    port      = 5044
  }
}



