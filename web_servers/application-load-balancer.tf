# Creating a Application Load Balancer 

# resource "yandex_alb_load_balancer" "web-balancer" {
#   name        = "web-load-balancer"
#   network_id  = yandex_vpc_network.network-1.id
#   #security_group_ids = ["<идентификатор_группы_безопасности>"]
  
#   allocation_policy {
#     location {
#       zone_id   = var.zone
#       subnet_id = yandex_vpc_subnet.subnet-1.id 
#     }
#     location {
#       zone_id   = var.zone1
#       subnet_id = yandex_vpc_subnet.subnet-2.id
      
#     }
#   }

    
#   listener {
#     name = "web-listener"
#     endpoint {
#       address {
#         external_ipv4_address {
#         }
#       }
#       ports = [ 80 ] 
#     }    
#     http {
#       handler {
#         http_router_id = yandex_alb_http_router.tf-router.id
#       }
#     }
#   }
  
#   log_options {
#     discard_rule {
#       http_code_intervals = ["HTTP_4XX"]
#       discard_percent = 75
#     }
#   }
# }

# Creating a   HTTP Router

# resource "yandex_alb_http_router" "tf-router" {
#   name      = "web-http-router"
#   #labels = {
#   #  tf-label    = "tf-label-value"
#   #  empty-label = ""s
#   #}
# }

# # Creating   virtual host 

# resource "yandex_alb_virtual_host" "web-virtual-host" {
#   name      = "web-virtual-host"
#   http_router_id = yandex_alb_http_router.tf-router.id
#   route {
#     name = "web-route"
#     http_route {
#       http_route_action {
#         backend_group_id = "${yandex_alb_backend_group.web-backend-group.id}"
#       }
#     }
#   }
# }

# Creating a  backend group 

# resource "yandex_alb_backend_group" "web-backend-group" {
#   name      = "web-backend-group"

#   http_backend {
#     name = "web-http-backend"
#     #weight = 1
#     #port = 8080
#     port = 80
#     target_group_ids = ["${yandex_alb_target_group.web-servers.id}"]
#     #tls {
#     #  sni = "backend-domain.internal"
#     #}
#     #load_balancing_config {
#     #  panic_threshold = 50
#     #}    
#     healthcheck {
#       timeout = "30s"
#       interval = "30s"
#       healthcheck_port = "80"
#       http_healthcheck {
#         path  = "/"
#       }
#     }
#   }
# }

# Creating a target group 

# resource "yandex_alb_target_group" "web-servers" {
#   name           = "web-servers-target-group"

#   target {
#     subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
#     ip_address   = "${yandex_compute_instance.vm-1.network_interface[0].ip_address}"
#   }
  
#   target {
#     subnet_id = "${yandex_vpc_subnet.subnet-2.id}"    
#     ip_address   = "${yandex_compute_instance.vm-2.network_interface[0].ip_address}"
#   }
# }


