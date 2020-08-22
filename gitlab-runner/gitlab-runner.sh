#!/bin/bash

set -e

os_id=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
os_codename=$(lsb_release -cs)

apt-get update

apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common gnupg2

curl -fsSL https://packages.gitlab.com/runner/gitlab-runner/gpgkey | apt-key add -

add-apt-repository \
  "deb [arch=amd64] https://packages.gitlab.com/runner/gitlab-runner/$os_id/ \
  $os_codename main"

apt-get update

apt-get install -y gitlab-runner

gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.com" \
  --registration-token "${registration_token}" \
  --executor "docker" \
  --docker-image "docker:stable" \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock"

sed "s/concurrent = .*/concurrent = 10/g" /etc/gitlab-runner/config.toml

systemctl restart gitlab-runner
