variable "cloud_id" {
  default = ""
}

variable "folder_id" {
  default = ""
}

variable "ubuntu-2004-lts" {
  default = ""
}

variable "token" {
  type = string
  default = ""  
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  default     = ""
}

variable "ssh_private_key" {
  description = "SSH private key"
  type        = string
  default     = ""
}

variable "node_zones" {
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}

variable "zone-a" {
  type        = string
  default     = "ru-central1-a"
}

variable "zone-b" {
  type        = string
  default     = "ru-central1-b"
}

variable "zone-d" {
  type        = string
  default     = "ru-central1-d"
}

variable "cidr-a" {
  type    = list(string)
  default = ["10.0.1.0/24"]    
}

variable "cidr-b" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "cidr-d" {
  type    = list(string)
  default = ["10.0.3.0/24"]
}
