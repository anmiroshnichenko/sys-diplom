output "external_vm1" {
value = yandex_compute_instance.vm-1.network_interface[0].nat_ip_address
}

output "external_vm2" {
value = yandex_compute_instance.vm-2.network_interface[0].nat_ip_address
}

output "internal_vm1" {
value = yandex_compute_instance.vm-1.network_interface[0].ip_address
}

output "internal_vm2" {
value = yandex_compute_instance.vm-2.network_interface[0].ip_address
}

output "alb_ip_address" {
  value = yandex_alb_load_balancer.web-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}
