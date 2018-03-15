FROM debian:9.3

MAINTAINER Carlo Contino <c.contino@cineca.it>

RUN apt-get update && apt-get install -y locales nano wget php7.0 php7.0-xml composer php7.0-xdebug php7.0-apc apache2

RUN echo "Europe/Rome" > /etc/timezone && \
        dpkg-reconfigure -f noninteractive tzdata && \
        sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
        sed -i -e 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/' /etc/locale.gen && \
        echo 'LANG="it_IT.UTF-8"'>/etc/default/locale && \
        dpkg-reconfigure --frontend=noninteractive locales && \
        update-locale LANGit_IT.UTF-8
ENV LANG it_IT.UTF-8
ENV LANGUAGE it_IT:it
ENV LC_ALL it_IT.UTF-8

RUN apt-get install -y build-essential libssl-dev nodejs-legacy yarn

RUN a2enmod rewrite

EXPOSE 8000
EXPOSE 80

ADD docker-config/000-default.conf /etc/apache2/sites-enabled/000-default.conf

ENTRYPOINT service apache2 start && bash