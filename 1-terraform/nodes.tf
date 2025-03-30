resource "yandex_compute_instance" "master" {  
  count                     = 1
  name                      = "master"
  zone                      = var.zone-d
  hostname                  = "master"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  labels = {
    index = "${count.index}"
  } 
 
  scheduling_policy {
  preemptible = true
  }

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.ubuntu-2004-lts}"
      type        = "network-ssd"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-d.id
    nat       = true
  }
  
  metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }
}


resource "yandex_compute_instance" "worker" {
  count                     = 2
  name                      = "worker-${count.index + 1}"
  zone                      = var.node_zones[count.index]
  hostname                  = "worker-${count.index}"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  labels = {
    index = "${count.index}"
  }

  scheduling_policy {
  preemptible = true
  }

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.ubuntu-2004-lts}"
      type        = "network-ssd"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = lookup(
      {
        "ru-central1-a" = yandex_vpc_subnet.public-a.id,
        "ru-central1-a" = yandex_vpc_subnet.public-b.id,
        "ru-central1-d" = yandex_vpc_subnet.public-d.id,
      },
      var.node_zones[count.index],
      null
    )
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh-keys}"
    serial-port-enable = "1"
    user-data          = data.template_file.cloudinit.rendered
  }
}
