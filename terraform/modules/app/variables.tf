variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Instance resource zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_ip {
  description = "DB instance IP"
  default     = ""
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}
