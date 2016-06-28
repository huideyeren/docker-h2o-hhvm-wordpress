FROM ubuntu:latest

MAINTAINER Takakura Yusuke (takakura.yusuke@gmail.com)

LABEL Description = "H2O Web Server"

# Install Package

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y libuv-dev libyaml-dev libssl-dev cmake git build-essential

# Build H2O

WORKDIR /tmp
RUN git clone https://github.com/kazuho/h2o.git
WORKDIR /tmp/h2o
RUN git submodule update --init --recursive
RUN cmake .
RUN make h2o
RUN mv /tmp/h2o/h2o /usr/sbin/h2o
RUN mkdir /etc/h2o
RUN mkdir /var/www
ADD h2o.conf /etc/h2o/h2o.conf

RUN rm -rf /tmp/h2o

CMD h2o -c /etc/h2o/h2o.conf

VOLUME ["/etc/h2o", "/var/www"]
