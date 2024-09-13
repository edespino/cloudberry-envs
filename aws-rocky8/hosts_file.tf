resource "local_file" "hosts_file" {
  count    = length(aws_instance.rocky_linux)
  filename = "${path.module}/hosts_${count.index}"
  content  = <<-EOT
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
%{ for i, instance in aws_instance.rocky_linux ~}
${aws_network_interface.private_nic[i].private_ip} ${i == 0 ? "mdw" : "sdw${i}"}
%{ endfor ~}
EOT
}

resource "null_resource" "copy_hosts_file" {
  count = length(aws_instance.rocky_linux)

  connection {
    type        = "ssh"
    user        = "rocky"
    private_key = file("${path.module}/${var.env_prefix}_generated_key.pem")
    host        = aws_instance.rocky_linux[count.index].public_ip
  }

  provisioner "file" {
    source      = "${path.module}/hosts_${count.index}"
    destination = "/tmp/hosts"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/hosts /etc/hosts",
      "sudo chown root:root /etc/hosts",
      "sudo chmod 644 /etc/hosts",
      "sudo hostnamectl set-hostname ${count.index == 0 ? "mdw" : "sdw${count.index}"}",
      "sudo ip addr add ${aws_network_interface.private_nic[count.index].private_ip}/24 dev eth1 || true",
      "sudo ip link set eth1 up",
    ]
  }

  depends_on = [
    local_file.hosts_file,
    aws_network_interface_attachment.private_nic_attachment
  ]
}
