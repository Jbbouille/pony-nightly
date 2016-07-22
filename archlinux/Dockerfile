FROM pritunl/archlinux:latest

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN pacman --noconfirm -S pcre2 clang llvm llvm-libs ncurses gcc-libs zlib openssl make gcc ruby git curl

RUN ln -s /usr/bin/x86_64-pc-linux-gnu-gcc /usr/bin/x86_64-linux-gnu-gcc

RUN mkdir /home/pony

RUN git clone --depth 30 https://github.com/ponylang/ponyc.git /home/pony/ponyc

COPY main.sh /home/pony/

RUN gem install fpm

ENTRYPOINT bash /home/pony/main.sh