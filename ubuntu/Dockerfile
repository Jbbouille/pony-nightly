FROM ubuntu:xenial

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \ 
	apt-get -y 	install build-essential git rubygems ruby-dev \
            	zlib1g-dev libncurses5-dev libssl-dev libpcre2-16-0 llvm-3.7-dev curl

RUN mkdir /home/pony

RUN git clone https://github.com/ponylang/ponyc.git /home/pony/ponyc

COPY main.sh /home/pony/

RUN gem install fpm

ENTRYPOINT bash /home/pony/main.sh