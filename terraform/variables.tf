variable project {
  description = "Project ID"
}

variable "count" {
  default = "1"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the private key used for provisioners ssh connect"
}

variable zone {
  description = "Instance resource zone"
  default     = "europe-west1-b"
}
