FROM fedora:23

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN dnf update -y && \
    dnf install -y 	ncurses-devel openssl-devel pcre2 git zlib-devel fedora-packager rpmdevtools \
    				make automake gcc gcc-c++ kernel-devel @development-tools tar xz \
    				which rubygems rubygem-bundler ruby-devel mariadb-devel && \
    dnf clean all

RUN mkdir /home/pony && \
	curl --silent --output /home/pony/clang+llvm-3.8.0-x86_64-fedora23.tar.xz http://llvm.org/releases/3.8.0/clang+llvm-3.8.0-x86_64-fedora23.tar.xz

RUN tar xf /home/pony/clang+llvm-3.8.0-x86_64-fedora23.tar.xz -C /home/pony/ && \
	cp -R /home/pony/clang+llvm-3.8.0-x86_64-fedora23/libexec/* /usr/libexec/ && \
	cp -R /home/pony/clang+llvm-3.8.0-x86_64-fedora23/bin/* /usr/bin/ && \
	cp -R /home/pony/clang+llvm-3.8.0-x86_64-fedora23/include/* /usr/include/ && \
	cp -R /home/pony/clang+llvm-3.8.0-x86_64-fedora23/lib/* /usr/lib/ && \
	cp -R /home/pony/clang+llvm-3.8.0-x86_64-fedora23/share/* /usr/share/

RUN curl -L --silent --output /home/pony/github-release.tar.bz2 https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 && \
	tar xf /home/pony/github-release.tar.bz2 -C /home/pony/ && \
	cp /home/pony/bin/linux/amd64/github-release /usr/bin/

RUN git clone https://github.com/ponylang/ponyc.git /home/pony/ponyc

COPY main.sh /home/pony/

RUN gem install fpm

ENTRYPOINT sh /home/pony/main.sh