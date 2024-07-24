resource "null_resource" "generate_ssh_keys" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ${path.root}/ssh_keys
      if [ ! -f ${path.root}/ssh_keys/id_rsa-VMs ]; then
        ssh-keygen -t rsa -b 4096 -C VMs -f ${path.root}/ssh_keys/id_rsa-VMs -P "" -q;
      fi
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

data "local_file" "private_key" {
  filename = "${path.root}/ssh_keys/id_rsa-VMs"
  depends_on = [null_resource.generate_ssh_keys]
}

data "local_file" "public_key" {
  filename = "${path.root}/ssh_keys/id_rsa-VMs.pub"
  depends_on = [null_resource.generate_ssh_keys]
}

resource "null_resource" "remove_ssh_keys" {
  provisioner "local-exec" {
    command = <<EOT
      rm -f ${path.root}/ssh_keys/id_rsa-VMs ${path.root}/ssh_keys/id_rsa-VMs.pub
      rmdir ${path.root}/ssh_keys
    EOT

    when = destroy
  }

  triggers = {
    vm_count = var.vm_count
  }
}
