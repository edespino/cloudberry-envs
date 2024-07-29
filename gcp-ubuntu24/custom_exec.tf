resource "null_resource" "custom_exec" {
  count = var.INSTANCE_COUNT

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/${var.GCP_USER_NAME}/.ssh/id_rsa",
      "chmod 644 /home/${var.GCP_USER_NAME}/.ssh/id_rsa.pub",
      "sudo hostnamectl set-hostname ${var.VM_NAME}-${count.index + 1}",
    ]

    connection {
      type        = "ssh"
      user        = "${var.GCP_USER_NAME}"
      private_key = module.ssh_keys.PRIVATE_KEY
      host        = module.instances.INSTANCE_IPS[count.index]
    }
  }

  depends_on = [module.ssh_keys]
}
