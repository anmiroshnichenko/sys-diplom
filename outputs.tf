output "maintest_vm1" {
value = yandex_compute_instance.vm-1.boot_disk[0].disk_id
}

output "maintest_vm2" {
value = yandex_compute_instance.vm-2.boot_disk[0].disk_id
}

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

output "target_group_ids" {
value = yandex_lb_target_group.web-servers.id
}

output "lb_ip_address" {
  value = yandex_lb_network_load_balancer.lb-netology.*
}
