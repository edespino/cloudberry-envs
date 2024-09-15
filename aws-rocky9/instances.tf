resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.env_prefix}-generated_key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_network_interface" "private_nic" {
  count          = var.vm_count
  subnet_id      = aws_subnet.private.id
  private_ips    = ["10.0.2.${count.index + 100}"]
  security_groups = [aws_security_group.allow_all.id]
  tags = {
    Name = "${var.env_prefix}-private-nic-${count.index}"
  }
}

resource "null_resource" "pem_file" {
  provisioner "local-exec" {
    command = <<EOT
      rm -f ${var.env_prefix}_generated_key.pem
      echo '${tls_private_key.example.private_key_pem}' > ${var.env_prefix}_generated_key.pem
      chmod 400 ${var.env_prefix}_generated_key.pem
    EOT
  }
}

resource "aws_instance" "rocky_linux" {
  count                       = var.vm_count
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.root_disk_size
    volume_type = "gp2" # General Purpose SSD
  }

  vpc_security_group_ids = [aws_security_group.allow_all.id]

  # Use cloud-init content directly, only passing basic variables
  user_data = templatefile("${path.module}/cloud-init.yml", {
    hostname = count.index == 0 ? "mdw" : "sdw${count.index}",
  })

  tags = {
    Name = "${var.env_prefix}-instance-${count.index}"
  }

  depends_on = [null_resource.pem_file]
}

resource "aws_ebs_volume" "data_volume" {
  count             = var.vm_count * var.data_drive_count
  availability_zone = "${var.region}a"
  size              = var.data_drive_size
  type              = var.data_drive_type

  # Conditional IOPS for io1/io2 and throughput for gp3
  iops = var.data_drive_type == "io1" || var.data_drive_type == "io2" ? var.iops : null
  throughput = var.data_drive_type == "gp3" ? var.throughput : null

  tags = {
    Name = "${var.env_prefix}-data-volume-${count.index}"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  count = var.vm_count * var.data_drive_count

  device_name = "/dev/sd${element(["f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"], count.index % var.data_drive_count)}"

  volume_id   = aws_ebs_volume.data_volume[count.index].id
  instance_id = aws_instance.rocky_linux[floor(count.index / var.data_drive_count)].id

  depends_on = [
    aws_instance.rocky_linux,
    aws_ebs_volume.data_volume
  ]
}

resource "aws_network_interface_attachment" "private_nic_attachment" {
  count                = var.vm_count
  instance_id          = aws_instance.rocky_linux[count.index].id
  network_interface_id = aws_network_interface.private_nic[count.index].id
  device_index         = 1

  depends_on = [
    aws_instance.rocky_linux, # Ensure the instance is fully provisioned
    aws_network_interface.private_nic, # Ensure NIC is created
  ]
}

resource "local_file" "instances_info" {
  content  = jsonencode({
    names = aws_instance.rocky_linux[*].tags.Name
    ips   = aws_instance.rocky_linux[*].public_ip
  })
  filename = "${path.module}/${var.env_prefix}_instances_info.json"
}
