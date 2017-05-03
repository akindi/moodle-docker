FROM ubuntu:trusty
MAINTAINER Julen Pardo <julen.pardo@outlook.es>

USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	git \
	curl \
	php5 \
	apache2 \
	postgresql-9.3 \
	libapache2-mod-php5 \
	php5-pgsql \
	php5-curl \
	php5-intl \
	php5-xmlrpc \
	php5-json \
	php5-gd

# Moodle download & installation.
RUN mkdir -p /var/moodledata/
RUN chmod 777 /var/moodledata/
RUN rm --recursive /var/www/html/*
RUN chmod 755 /var/www/html/

# PHPUnit configuration & initialization.
RUN mkdir /var/phpu_moodle/
RUN chmod 777 /var/phpu_moodle/
RUN locale-gen en_AU.UTF-8 # Necessary for PHPUnit.
RUN update-locale

# Startup script.
COPY scripts/index.php /var/www/html/index.php
COPY scripts/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 777 /docker-entrypoint.sh
CMD ["/docker-entrypoint.sh"]

EXPOSE 80 443
