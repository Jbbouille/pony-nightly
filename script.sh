#!/bin/sh

set -e

#docker run -e PONY_VERSION=$PONY_VERSION ponyc-archlinux
#docker run -e PONY_VERSION=$PONY_VERSION ponyc-fedora
docker run -e PONY_VERSION=$PONY_VERSION -e BINTRAY_TOKEN=$BINTRAY_TOKEN -e BINTRAY_USER=$BINTRAY_USER ponyc-ubuntu