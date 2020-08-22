resource "tls_private_key" "new_ssh_key" {
  algorithm = "ECDSA"
  ecdsa_curve = "P384"
}

resource "digitalocean_ssh_key" "ssh_key" {
  name = "${var.resource_prefix}-key"
  public_key = tls_private_key.new_ssh_key.public_key_openssh
  lifecycle {
    ignore_changes = [public_key]
  }
  depends_on = [tls_private_key.new_ssh_key]
}

resource "digitalocean_droplet" "host" {
  count = var.droplet_count
  name = format("${var.resource_prefix}-%d", count.index + 1)
  ssh_keys = [digitalocean_ssh_key.ssh_key.id]
  region = var.droplet_region
  size = var.droplet_size
  image = var.droplet_image
  backups = false
  private_networking = true
  user_data = var.droplet_user_data
  tags = var.droplet_tags
  connection {
    host = self.ipv4_address
    private_key = tls_private_key.new_ssh_key.private_key_pem
    agent = false
  }
  provisioner "remote-exec" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do sleep 2; done",
    ]
  }
  lifecycle {
    ignore_changes = [ssh_keys, region, image, user_data]
  }
  depends_on = [digitalocean_ssh_key.ssh_key]
}
