# Pony Nightly
## Goal
* Build Ponyc and its package each night

# Debian APT repo
`deb https://dl.bintray.com/jbbouille/deb {distribution} {components}`

# Rpm yum/dnf repo
`wget https://bintray.com/jbbouille/rpm/rpm -O bintray-jbbouille-rpm.repo`
`sudo mv bintray-jbbouille-rpm.repo /etc/yum.repos.d/`

# Arch repo
There is no repository of type archlinux on bintray so you have to download it manualy: 
`curl -L "https://dl.bintray.com/jbbouille/archlinux/ponyc-nightly/[version]" -o ponyc-[version]-1-x86_64.pkg.tar.xz`

then install the package with
`pacman -U ponyc-[version]-x86_64.pkg.tar.xz`