#!/bin/sh

set -e

sudo apt-get install -o Dpkg::Options::="--force-confold" --force-yes -y docker-engine