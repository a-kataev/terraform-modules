# terraform-modules/gitlab-runner

## Overview

Install gitlab-runner.

## Limitations

Use module only on ubuntu/debian system. Tested on ubuntu 18.04, 20.04.

## Usage

Use this module in your tf file:

```hcl
data "local_file" "ssh_key_private" {
  filename = pathexpand("~/.ssh/id_rsa")
}

module "gitlab-runner" {
  source = "git::https://github.com/a-kataev/terraform-modules.git//gitlab-runner"
  connection_hosts = ["111.122.133.144"]
  connection_private_key = data.local_file.ssh_key_private.content
  registration_token = ""
  tag_list = ["docker", "seflhost"]
}
```

Update provider plugins:

```shell
$ terraform init
```

Apply changes:

```shell
$ terraform apply
```

## Requirements

terraform >= 0.12
