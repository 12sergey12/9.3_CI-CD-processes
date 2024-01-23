resource "yandex_compute_instance" "web" {
  count = 2
  name = "sonar-${count.index + 1}"
  resources {
    cores         = 2
    memory        = 4
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8rv9qura2dv7rrg4p2"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}
