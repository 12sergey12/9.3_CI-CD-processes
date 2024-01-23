resource "yandex_compute_instance" "fe_instance" {

depends_on = [ yandex_compute_instance.web ]

  for_each = { for vm in local.vms_fe: "${vm.vm_name}" => vm }
  name = each.key
  platform_id = "standard-v1"
  resources {
     cores         = each.value.cpu
     memory        = each.value.ram
     core_fraction = each.value.frac
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
#    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
    ssh-keys = local.ssh
  }
}



locals {
  vms_fe = [
    { 
       vm_name = "sonar-01"
       cpu     = 2
       ram     = 4
       frac    = 5
    },
    {
       vm_name = "nexus-01"
       cpu     = 2
       ram     = 4
       frac    = 5
    }
  ] 
}

locals {
  ssh = "centos:${file("~/.ssh/id_rsa.pub")}"
}
