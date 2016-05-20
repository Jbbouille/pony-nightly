#!/bin/sh

set -e

sudo apt-get install -o Dpkg::Options::="--force-confold" --force-yes -y docker-engine
curl -L --silent --output /home/travis/build/Jbbouille/github-release.tar.bz2 https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2
tar xf /home/travis/build/Jbbouille/github-release.tar.bz2 -C /home/travis/build/Jbbouille/