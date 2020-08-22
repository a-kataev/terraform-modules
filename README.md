# tf-modules

## Overview

Used terraform modules.

## Modules

* [digitalocean](digitalocean/README.md)
* [docker](docker/README.md)

## Usage

### Via link

```hcl
module "do" {
  source = "git::https://github.com/a-kataev/tf-modules.git//digitalocean"
}
```

### Via local copy

Clone this repository to directory `modules`:

```shell
$ git clone git@github.com:a-kataev/tf-modules ./modules
```

Use local path in module source:

```hcl
module "do" {
  source = "./modules/digitalocean"
}
```
