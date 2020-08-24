# terraform-modules/digitalocean

## Overview

Create digitalocean host and key.

## Limitations

This module creates one new ssh key for all hosts.

Key name `${var.resource_prefix}-key`. Host name `${var.resource_prefix}-X`, where X is the index of `droplet_count`.

Variable `resource_prefix` divides resources on the provider. Avoid coincidences!

## Usage

Set environment variables `DIGITALOCEAN_TOKEN` or `DIGITALOCEAN_ACCESS_TOKEN`.

Use this module in your tf file:

```hcl
module "do" {
  source = "git::https://github.com/a-kataev/terraform-modules.git//digitalocean"
  resource_prefix = "new"
  droplet_count = 1
  droplet_region = "fra1"
  droplet_size = "s-1vcpu-1gb"
  droplet_image = "ubuntu-20-04-x64"
}

output "do_ip_adresses" {
  value = module.do.host.*.ipv4_address
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

Look at output variable:

```
...
Outputs:

do_ip_adresses = [
  "111.122.133.144",
]
...
```

## Requirements

terraform >= 0.12
