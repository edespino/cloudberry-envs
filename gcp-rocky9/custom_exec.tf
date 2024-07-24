resource "null_resource" "custom_exec" {
  count = var.instance_count

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/eespino/.ssh/id_rsa",
      "chmod 644 /home/eespino/.ssh/id_rsa.pub",
      "sudo hostnamectl set-hostname ${var.vm_name}-${count.index + 1}",
    ]

    connection {
      type        = "ssh"
      user        = "eespino"
      private_key = module.ssh_keys.private_key
      host        = module.instances.instance_ips[count.index]
    }
  }

  depends_on = [module.ssh_keys]
}
