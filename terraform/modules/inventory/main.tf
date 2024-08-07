resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      cat > ${path.root}/inventory.ini <<EOF
[vms]
${join("\n", var.INSTANCE_IPS)}
EOF
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "remove_inventory" {
  provisioner "local-exec" {
    command = "rm -f ${path.root}/inventory.ini"
    when    = destroy
  }

  triggers = {
    vm_count = var.INSTANCE_COUNT
  }
}
