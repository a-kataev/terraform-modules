locals {
  script_name = "gitlab-runner.sh"
}

data "template_file" "script" {
  template = file("${path.module}/${local.script_name}")
  vars = {
    registration_token = var.registration_token
  }
}

resource "null_resource" "gitlab-runner" {
  count = length(var.connection_hosts)
  connection {
    host = element(var.connection_hosts, count.index)
    private_key = var.connection_private_key
    agent = false
  }
  provisioner "file" {
    content = data.template_file.script.rendered
    destination = "/tmp/${local.script_name}"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${local.script_name}",
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "/tmp/${local.script_name}",
    ]
    on_failure = fail
  }
  provisioner "remote-exec" {
    inline = [
      "rm -rf /tmp/${local.script_name}",
    ]
  }
}
