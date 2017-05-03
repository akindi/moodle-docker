#!/bin/bash

# Start Postgresql & Apache services.
/etc/init.d/postgresql start
/etc/init.d/apache2 start

# Create database user for Moodle, and database for PHPUnit.
sudo -u postgres /usr/bin/psql -c "CREATE USER moodleuser WITH ENCRYPTED PASSWORD 'm00dl3us3r!'"
sudo -u postgres /usr/bin/psql -c "CREATE DATABASE moodledb WITH OWNER moodleuser ENCODING 'UTF8' TEMPLATE template0"

perl -pi -e 's/display_errors = Off/display_errors = On/g' /etc/php5/*/php.ini
perl -pi -e 's/error_reporting = .*/error_reporting = E_ALL/g' /etc/php5/*/php.ini

# Install Moodle.
/usr/bin/php /var/www/html/moodle/admin/cli/install.php \
    --lang=en \
    --wwwroot=${MOODLE_URL%%/}/moodle/ \
    --dataroot=/var/moodledata/ \
    --dbtype=pgsql \
    --dbhost=localhost \
    --dbname=moodledb \
    --dbuser=moodleuser \
    --dbpass=m00dl3us3r! \
    --dbport=5432 \
    --prefix=mdl_ \
    --fullname='Akindi Moodle' \
    --shortname=moodle \
    --adminuser=admin \
    --adminpass=password \
    --non-interactive \
    --agree-license

chmod 755 -R /var/www/html/moodle/

echo '
$CFG->debug = 32767;
$CFG->debugdisplay = true;
ini_set("display_errors", "on");
ini_set("log_errors", "on");
ini_set("display_startup_errors", "on");
ini_set("error_reporting", E_ALL);
' >> /var/www/html/moodle/config.php

# Never ending command for maintaining container alive.
tail -F -n0 /var/log/apache2/*
