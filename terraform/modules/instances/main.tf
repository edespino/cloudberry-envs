resource "google_compute_instance" "vm" {
  count                     = var.instance_count
  name                      = "${var.vm_name}-${count.index + 1}"
  hostname                  = "${var.vm_name}-${count.index + 1}.espino-apache.com"
  machine_type              = var.machine_type
  zone                      = var.gcp_zone
  tags                      = ["ssh"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.boot_disk_size
      type  = var.disk_type
    }
  }

  scheduling {
    preemptible                 = true
    automatic_restart           = false
    provisioning_model          = "SPOT"
    instance_termination_action = "STOP"
  }

  network_interface {
    subnetwork = var.subnet_id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  metadata = {
    ssh-keys = "eespino:${var.public_key}"
  }

  provisioner "file" {
    source      = "${path.root}/ssh_keys/id_rsa-VMs"
    destination = "/home/eespino/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = "eespino"
      private_key = var.private_key
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }

  provisioner "file" {
    source      = "${path.root}/ssh_keys/id_rsa-VMs.pub"
    destination = "/home/eespino/.ssh/id_rsa.pub"

    connection {
      type        = "ssh"
      user        = "eespino"
      private_key = var.private_key
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }

  provisioner "file" {
    source      = "files/90-db-sysctl.conf"
    destination = "/home/eespino/90-db-sysctl.conf"

    connection {
      type        = "ssh"
      user        = "eespino"
      private_key = var.private_key
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }
}
