#!/bin/bash

set -e

make config=release -C ponyc/
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

ponyc/build/release/ponyc ponyc/examples/helloworld
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

HELLO_WORLD=$(./helloworld)
if [[ $HELLO_WORLD != "Hello, world." ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

mkdir -p ponyc-$PONY_VERSION/usr/bin
mkdir -p ponyc-$PONY_VERSION/usr/lib
cp ponyc/build/release/ponyc ponyc-$PONY_VERSION/usr/bin
cp ponyc/build/release/libponyc.a ponyc-$PONY_VERSION/usr/lib
cp ponyc/build/release/libponyrt.a ponyc-$PONY_VERSION/usr/lib

fpm -s dir -t osxpkg -n ponyc -v $PONY_VERSION -C ponyc-$PONY_VERSION/ -d "pcre2" -d "libressl"
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

sudo installer -pkg ponyc-$PONY_VERSION.pkg -target /
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

ponyc -v
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

curl -H "Content-Type: application/json" -u$BINTRAY_USER:$BINTRAY_TOKEN -X POST -d '{"name": "'$PONY_VERSION'","desc": "This is the ponyc nightly"}' https://api.bintray.com/packages/$BINTRAY_USER/osx/ponyc-nightly/versions
if [[ $? -ne 0 ]]; then
	echo "Error during upload of version"
	exit 1
fi

curl -T ponyc-$PONY_VERSION.pkg -u$BINTRAY_USER:$BINTRAY_TOKEN -H "X-Bintray-Publish: 1" https://api.bintray.com/content/$BINTRAY_USER/osx/ponyc-nightly/$PONY_VERSION/
if [[ $? -ne 0 ]]; then
	echo "Error during upload of file"
	exit 1
fi