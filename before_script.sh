#!/bin/sh

set -e

docker build -t ponyc-archlinux archlinux/
docker build -t ponyc-fedora fedora/
docker build -t ponyc-ubuntu ubuntu/