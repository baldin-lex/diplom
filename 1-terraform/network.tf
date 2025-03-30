resource "yandex_vpc_network" "vps" {
  name = "net"
}

resource "yandex_vpc_subnet" "public-a" {
  name           = "subnet-a"
  zone           = var.zone-a
  network_id     = yandex_vpc_network.vps.id
  v4_cidr_blocks = var.cidr-a
}

resource "yandex_vpc_subnet" "public-b" {
  name           = "subnet-b"
  zone           = var.zone-b
  network_id     = yandex_vpc_network.vps.id
  v4_cidr_blocks = var.cidr-b
}

resource "yandex_vpc_subnet" "public-d" {
  name           = "subnet-d"
  zone           = var.zone-d
  network_id     = yandex_vpc_network.vps.id
  v4_cidr_blocks = var.cidr-d
}
