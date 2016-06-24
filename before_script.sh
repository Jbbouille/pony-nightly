#!/bin/sh

set -e

if [[ $TRAVIS_OS_NAME = "linux"]]; then
	docker build -t ponyc-archlinux archlinux/
	docker build -t ponyc-fedora fedora/
	docker build -t ponyc-ubuntu ubuntu/
fi

if [[ $TRAVIS_OS_NAME = "osx"]]; then
	git clone --depth 30 https://github.com/ponylang/ponyc.git
fi