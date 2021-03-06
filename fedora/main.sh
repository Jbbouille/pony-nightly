#!/bin/bash

set -e

make config=release -C /home/pony/ponyc

if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

/home/pony/ponyc/build/release/ponyc /home/pony/ponyc/examples/helloworld
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

HELLO_WORLD=$(/helloworld)
if [[ $HELLO_WORLD != "Hello, world." ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

mkdir -p /home/pony/ponyc-$PONY_VERSION/usr/bin
mkdir -p /home/pony/ponyc-$PONY_VERSION/usr/lib
cp /home/pony/ponyc/build/release/ponyc /home/pony/ponyc-$PONY_VERSION/usr/bin
cp /home/pony/ponyc/build/release/libponyc.a /home/pony/ponyc-$PONY_VERSION/usr/lib
cp /home/pony/ponyc/build/release/libponyrt.a /home/pony/ponyc-$PONY_VERSION/usr/lib

fpm -s dir -t rpm -n ponyc -v $PONY_VERSION -C /home/pony/ponyc-$PONY_VERSION/ -d "openssl-devel" -d "pcre2"
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

PONY_TEMP_VERSION=$(date +%Y_%m_%d)

dnf install -y ponyc-$PONY_VERSION-1.x86_64.rpm
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

ponyc -v
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

dnf remove -y ponyc
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

curl -H "Content-Type: application/json" -u$BINTRAY_USER:$BINTRAY_TOKEN -X POST -d '{"name": "'$PONY_VERSION'","desc": "This is the ponyc nightly"}' https://api.bintray.com/packages/$BINTRAY_USER/rpm/ponyc-nightly/versions
if [[ $? -ne 0 ]]; then
	echo "Error during upload of version"
	exit 1
fi

curl -T ponyc-$PONY_VERSION-1.x86_64.rpm -u$BINTRAY_USER:$BINTRAY_TOKEN -H "X-Bintray-Publish: 1" https://api.bintray.com/content/$BINTRAY_USER/rpm/ponyc-nightly/$PONY_VERSION/
if [[ $? -ne 0 ]]; then
	echo "Error during upload of file"
	exit 1
fi