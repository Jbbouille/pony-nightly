#!/bin/sh

set -e

/home/travis/build/Jbbouille/bin/linux/amd64/github-release edit --user Jbbouille --repo try-ponyc-release --tag v$PONY_VERSION --name "Ponyc nightly $PONY_VERSION" --description "Pony nightly"