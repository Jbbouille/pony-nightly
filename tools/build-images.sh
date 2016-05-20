#!/bin/sh

set -e

docker build -t ponyc-arch tools/archlinux/
docker build -t ponyc-ubuntu tools/fedora/
docker build -t ponyc-fedora tools/ubuntu/