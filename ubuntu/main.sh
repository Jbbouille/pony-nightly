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

fpm --deb-no-default-config-files -s dir -t deb -n ponyc -v $PONY_VERSION -C /home/pony/ponyc-$PONY_VERSION/ -d "libpcre2-16-0" -d "libssl-dev"
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

dpkg -i ponyc_"$PONY_VERSION"_amd64.deb
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

ponyc -v
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

dpkg -r ponyc
if [[ $? -ne 0 ]]; then
	echo "Error during the building of Pony"
	exit 1
fi

mv ponyc_"$PONY_VERSION"_amd64.deb ponyc_"$PONY_VERSION"_x86_64.deb

curl -H "Content-Type: application/json" -u$BINTRAY_USER:$BINTRAY_TOKEN -X POST -d '{"name": "'$PONY_VERSION'","desc": "This is the ponyc nightly"}' https://api.bintray.com/packages/$BINTRAY_USER/deb/ponyc-nightly/versions
if [[ $? -ne 0 ]]; then
	echo "Error during upload of version"
	exit 1
fi

curl -T ponyc_"$PONY_VERSION"_x86_64.deb -u$BINTRAY_USER:$BINTRAY_TOKEN -H "X-Bintray-Publish: 1" -H "X-Bintray-Debian-Distribution: xenial" -H "X-Bintray-Debian-Component: main" -H "X-Bintray-Debian-Architecture: amd64" https://api.bintray.com/content/$BINTRAY_USER/deb/ponyc-nightly/$PONY_VERSION/
if [[ $? -ne 0 ]]; then
	echo "Error during upload of file"
	exit 1
fi