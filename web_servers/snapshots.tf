# Creating a snapshots

# resource "yandex_compute_snapshot" "snapshot-vm1" {
#   name           = "snapshot-vm1"
#   source_disk_id = "${yandex_compute_instance.vm-1.boot_disk[0].disk_id}"
# }
# resource "yandex_compute_snapshot" "snapshot-vm2" {
#   name           = "snapshot-vm2"
#   source_disk_id = "${yandex_compute_instance.vm-2.boot_disk[0].disk_id}"
# }
# resource "yandex_compute_snapshot" "snapshot-prometheus" {
#   name           = "snapshot-prometheus"
#   source_disk_id = "${yandex_compute_instance.prometheus.boot_disk[0].disk_id}"
# }
# resource "yandex_compute_snapshot" "snapshot-grafana" {
#   name           = "snapshot-grafana"
#   source_disk_id = "${yandex_compute_instance.grafana.boot_disk[0].disk_id}"
# }
# resource "yandex_compute_snapshot" "snapshot-elasticsearch" {
#   name           = "snapshot-elasticsearch"
#   source_disk_id = "${yandex_compute_instance.elasticsearch.boot_disk[0].disk_id}"
# }
# resource "yandex_compute_snapshot" "snapshot-kibana" {
#   name           = "snapshot-kibana"
#   source_disk_id = "${yandex_compute_instance.kibana.boot_disk[0].disk_id}"
# }

Creating a snapshots

resource "yandex_compute_snapshot_schedule" "snapshot-vm" {
  name = "snapshot-vm"

  schedule_policy {
    expression = "00 00 * * *"
  }

  #retention_period = "168h"
  retention_period = "168h"
  
  snapshot_count = "7"

  snapshot_spec {
	  description = "daily"
  }

  disk_ids = ["${yandex_compute_instance.vm-1.boot_disk[0].disk_id}", "${yandex_compute_instance.vm-2.boot_disk[0].disk_id}", 
    "${yandex_compute_instance.prometheus.boot_disk[0].disk_id}", "${yandex_compute_instance.grafana.boot_disk[0].disk_id}", 
    "${yandex_compute_instance.elasticsearch.boot_disk[0].disk_id}", "${yandex_compute_instance.kibana.boot_disk[0].disk_id}"]
}