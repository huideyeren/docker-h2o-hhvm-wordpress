FROM ubuntu:latest

MAINTAINER Takakura Yusuke (takakura.yusuke@gmail.com)

LABEL Description = "Wordpress"

WORKDIR /tmp

ENV WORDPRESS_VERSION 4.5.3-ja

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y wget pwgen

RUN mkdir /var/www

WORKDIR /var

RUN wget -o wordpress.tar.gz  https://ja.wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
  && tar -xzf wordpress.tar.gz -C www \
  && rm wordpress.tar.gz

COPY ./docker-entrypoint.sh /entrypoint.sh



# grr, ENTRYPOINT resets CMD now
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/var/www"]
