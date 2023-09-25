variable "zone" {
type = string
default = "ru-central1-a"
}

variable "zone1" {
type = string
default = "ru-central1-b"
}

variable "vm_image_family" {
type = string
default = "lemp"
}

variable "yc_image_family" {
  description = "family"
  #default     = "ubuntu-2004-lts"
  default     = "debian-11"
}

variable "image_id" {
  default = "fd8o6khjbdv3f1suqf69" # it's ubuntu-2004-lts
  #default = "fd8vtq76jue50g6b6tm7" # it's debian-11
}

variable "bastion_whitelist_ip" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
