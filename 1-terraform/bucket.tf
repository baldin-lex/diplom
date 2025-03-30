resource "yandex_iam_service_account" "sa-diplom" {
    name      = "sa-diplom"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
    folder_id = var.folder_id
    role      = "editor"
    member    = "serviceAccount:${yandex_iam_service_account.sa-diplom.id}"
    depends_on = [yandex_iam_service_account.sa-diplom]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
    service_account_id = yandex_iam_service_account.sa-diplom.id
}

resource "yandex_storage_bucket" "bucket-diplom" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = "baldinlex-diplom-bucket"
    acl    = "private"
    force_destroy = true
}

resource "local_file" "backend_file" {
  content  = <<EOT
endpoint = "storage.yandexcloud.net"
bucket = "${yandex_storage_bucket.bucket-diplom.bucket}"
region = "ru-central1"
key = "terraform/terraform.tfstate"
access_key = "${yandex_iam_service_account_static_access_key.sa-static-key.access_key}"
secret_key = "${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}"
skip_region_validation = true
skip_credentials_validation = true
EOT
  filename = "./backend.key"
}

resource "yandex_storage_object" "add_conf" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.bucket-diplom.bucket
    key = "terraform.tfstate"
    source = "./terraform.tfstate"
    acl    = "private"
    depends_on = [yandex_storage_bucket.bucket-diplom]
}
