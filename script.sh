#!/bin/sh

set -e

if [[ $TRAVIS_OS_NAME = "linux" ]]; then
	docker run -e PONY_VERSION=$PONY_VERSION -e BINTRAY_TOKEN=$BINTRAY_TOKEN -e BINTRAY_USER=$BINTRAY_USER ponyc-archlinux
	docker run -e PONY_VERSION=$PONY_VERSION -e BINTRAY_TOKEN=$BINTRAY_TOKEN -e BINTRAY_USER=$BINTRAY_USER ponyc-fedora
	docker run -e PONY_VERSION=$PONY_VERSION -e BINTRAY_TOKEN=$BINTRAY_TOKEN -e BINTRAY_USER=$BINTRAY_USER ponyc-ubuntu
fi

if [[ $TRAVIS_OS_NAME = "osx" ]]; then
	bash osx/main.sh
fi