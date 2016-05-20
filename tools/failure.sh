#!/bin/sh

set -e

git push origin :refs/tags/v$PONY_VERSION
/home/travis/build/Jbbouille/bin/linux/amd64/github-release delete --user Jbbouille --repo pony-nightly --tag v$PONY_VERSION