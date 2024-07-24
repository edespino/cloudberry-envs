resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      cat > ${path.root}/inventory.ini <<EOF
[gcp_vms]
${join("\n", var.instance_ips)}
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
    vm_count = var.instance_count
  }
}
