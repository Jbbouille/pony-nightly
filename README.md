# Pony Nightly
## Goal
* Build Ponyc and its package each night and push it on a repo.

## Debian APT repo
`deb https://dl.bintray.com/jbbouille/deb {distribution} {components}`

## Rpm yum/dnf repo
`wget https://bintray.com/jbbouille/rpm/rpm -O bintray-jbbouille-rpm.repo`
`sudo mv bintray-jbbouille-rpm.repo /etc/yum.repos.d/`

## Arch repo
There is no repository of type archlinux on bintray so you have to download it manualy: 
`curl -L "https://bintray.com/jbbouille/archlinux/download_file?file_path=ponyc-[version]-1-x86_64.pkg.tar.xz" -o ponyc-[version]-x86_64.pkg.tar.xz`

then install the package with
`pacman -U ponyc-[version]-x86_64.pkg.tar.xz`

## Os X repo
There is no repository of type brew on bintray so you have to download it manualy:
`curl -L "https://bintray.com/jbbouille/osx/download_file?file_path=ponyc-[version].pkg" -o ponyc-[version].pkg`

You MUST have installed `libressl` and `pcre2`. (You can install it with `brew install pcre2 libressl`)

then install the package with
`sudo installer -pkg ponyc-[version].pkg -target /`

## Version
Ponyc-nightly is build each day and the version of this package is YYYYmmdd (example for the 24 June of year 2016, the version will be 20160624).

## Bintray
You can find all of these repo on https://bintray.com/jbbouille