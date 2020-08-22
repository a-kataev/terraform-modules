terraform {
  required_version = ">= 0.12"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.1"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.4"
    }
  }
}
