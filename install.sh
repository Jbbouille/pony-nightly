#!/bin/sh

set -e

if [[ $TRAVIS_OS_NAME = "linux" ]]; then
	sudo apt-get install -o Dpkg::Options::="--force-confold" --force-yes -y docker-engine
fi

if [[ $TRAVIS_OS_NAME = "osx" ]]; then
	brew update
	brew install homebrew/versions/llvm38 pcre2 libressl
fi