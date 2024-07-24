output "private_key" {
  value = data.local_file.private_key.content
}

output "public_key" {
  value = data.local_file.public_key.content
}
