resource "google_compute_instance" "vm" {
  count                     = var.INSTANCE_COUNT
  name                      = "${var.VM_NAME}-${count.index + 1}"
  hostname                  = "${var.VM_NAME}-${count.index + 1}.espino-apache.com"
  machine_type              = var.MACHINE_TYPE
  zone                      = var.GCP_ZONE
  tags                      = ["ssh"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.BOOT_IMAGE
      size  = var.BOOT_DISK_SIZE
      type  = var.DISK_TYPE
    }
  }

  scheduling {
    preemptible                 = true
    automatic_restart           = false
    provisioning_model          = "SPOT"
    instance_termination_action = "STOP"
  }

  network_interface {
    subnetwork = var.SUBNET_ID

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  metadata = {
    ssh-keys = "${var.GCP_USER_NAME}:${var.PUBLIC_KEY}"
  }

  provisioner "file" {
    source      = "${path.root}/ssh_keys/id_rsa-VMs"
    destination = "/home/${var.GCP_USER_NAME}/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = var.GCP_USER_NAME
      private_key = var.PRIVATE_KEY
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }

  provisioner "file" {
    source      = "${path.root}/ssh_keys/id_rsa-VMs.pub"
    destination = "/home/${var.GCP_USER_NAME}/.ssh/id_rsa.pub"

    connection {
      type        = "ssh"
      user        = var.GCP_USER_NAME
      private_key = var.PRIVATE_KEY
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }
}
