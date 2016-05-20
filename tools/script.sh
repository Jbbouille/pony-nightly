#!/bin/sh

set -e

git tag $PONY_VERSION
git push -q https://$GITHUB_TOKEN@github.com/Jbbouille/pony-nightly --tags
/home/travis/build/Jbbouille/bin/linux/amd64/github-release release --user Jbbouille --repo pony-nightly --tag v$PONY_VERSION --name "Ponyc Nightly $PONY_VERSION" --description "Ponyc nightly" --draft

docker build -t ponyc-arch tools/archlinux/
docker build -t ponyc-ubuntu tools/fedora/
docker build -t ponyc-fedora tools/ubuntu/

docker run -e GITHUB_TOKEN=$GITHUB_TOKEN -e PONY_VERSION=$PONY_VERSION ponyc-arch
docker run -e GITHUB_TOKEN=$GITHUB_TOKEN -e PONY_VERSION=$PONY_VERSION ponyc-ubuntu
docker run -e GITHUB_TOKEN=$GITHUB_TOKEN -e PONY_VERSION=$PONY_VERSION ponyc-fedora