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

  egress {
    protocol       = "ANY"
    #description    = "we allow any egress, since we block on ingress"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

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

#   # ingress {
#   #   protocol       = "ICMP"
#   #   description    = "allows ping only from bastion"
#   #   security_group_id  = yandex_vpc_security_group.sg-bastion.id
#   # }

  ingress {
    protocol       = "TCP"
    description    = "allows remote access alb"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
    #security_group_id  = yandex_vpc_security_group.sg-ci-cd.id
    port      = 80
  } 

  # ingress {
  #   description = "Health checks from ALB"
  #   protocol = "TCP"
  #   predefined_target = "loadbalancer_healthchecks"  #[198.18.235.0/24, 198.18.248.0/24]
  # }

#   egress {
#     protocol       = "ANY"
#     description    = "Rule description 2"
#     v4_cidr_blocks = ["0.0.0.0/0"]
    #from_port      = 80
    #to_port        = 8099
  # }
  
  #egress {
  #  protocol       = "UDP"
  #  description    = "rule3 description"
  #  v4_cidr_blocks = ["192.168.10.0/24"]
  #  from_port      = 8090
  #  to_port        = 8099
  #}
}


