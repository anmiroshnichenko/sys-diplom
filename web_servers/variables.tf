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
  default     = "ubuntu-2004-lts"
}

variable "image_id" {
  default = "fd8d8etig5vu92nh75bm" # it's ubuntu-2004-lts
}
