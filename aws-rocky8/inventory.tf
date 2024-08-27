resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    environment = {
      INVENTORY_FILE = "${path.module}/${var.env_prefix}_inventory.ini"
      INFO_FILE = "${path.module}/${var.env_prefix}_instances_info.json"
      GENERATED_KEY_PEM = "../${var.terraform_project_dir_name}/${var.env_prefix}_generated_key.pem"
    }
    command = <<EOT
      #!/bin/bash
      set -e

      echo "[vms]" > $INVENTORY_FILE

      count=$(jq '.names | length' $INFO_FILE)
      for i in $(seq 0 $(($count - 1))); do
        name=$(jq -r ".names[$i]" $INFO_FILE)
        ip=$(jq -r ".ips[$i]" $INFO_FILE)
        echo "$name ansible_host=$ip ansible_user=rocky ansible_ssh_private_key_file=$GENERATED_KEY_PEM" >> $INVENTORY_FILE
      done
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [local_file.instances_info]
}

resource "null_resource" "remove_inventory" {
  provisioner "local-exec" {
    command = "rm -f ${self.triggers.inventory_file_path}"
    when    = destroy
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = "${timestamp()}",
    inventory_file_path = "${path.module}/${var.env_prefix}_inventory.ini"
  }
}
