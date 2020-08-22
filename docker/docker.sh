#!/bin/bash

os_id=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
os_codename=$(lsb_release -cs)

apt-get update

apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common gnupg2

curl -fsSL https://download.docker.com/linux/$os_id/gpg | apt-key add -

add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/$os_id \
  $os_codename stable"

apt-get update

apt-get install -y \
  containerd.io=${containerd_version} \
  docker-ce=5:${docker_version}~3-0~$os_id-$os_codename \
  docker-ce-cli=5:${docker_version}~3-0~$os_id-$os_codename

cat <<EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m"
   },
   "storage-driver": "overlay2"
}

EOF

mkdir -p /etc/systemd/system/docker.service.d

systemctl daemon-reload

systemctl restart docker
