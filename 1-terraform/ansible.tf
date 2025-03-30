resource "local_file" "inventory" {
 content = templatefile("${path.module}/hosts.tftpl",
    {
 workers = yandex_compute_instance.worker
 masters = yandex_compute_instance.master
    }
  )
 filename = "/home/baldin/new_diplom/modify/2-kubespray/inventory/mycluster/inventory.yaml"
}
