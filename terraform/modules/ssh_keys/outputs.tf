output "PRIVATE_KEY" {
  value = data.local_file.private_key.content
}

output "PUBLIC_KEY" {
  value = data.local_file.public_key.content
}
