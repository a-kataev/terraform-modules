output "ssh_key" {
  value = tls_private_key.new_ssh_key.private_key_pem
  sensitive = true
}

output "host" {
  value = digitalocean_droplet.host
}
