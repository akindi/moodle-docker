Moodle & Docker
===============

Dockerized Moodle for **development environment**!

This Dockerfile installs:

 - PostgreSQL.
 - Apache.
 - Moodle (you can choose Moodle version).
 - PHPUnit environment for Moodle.


## Download

Clone the repo:

  $ git clone https://github.com/akindi/moodle-docker

And clone the `moodle-local_akindi` repo into the same directory:

  $ git clone https://github.com/akindi/moodle-local_akindi


## Building the image

Run:

  $ ./build-moodle
  $ ./init-moodle 31

init-moodle will take some time. The instance will be ready after 'Installation
completed successfuly' is shown. Leave the command running to watch a tail of
the logs, or use ctrl-c to finish.

Then open: http://moodle.localhost:4431/moodle/

And login with: admin / password

Note: you may need to add `127.0.0.1  moodle.localhost` to `/etc/hosts` on your
development machine.

To install a different version of Moodle, use `./init-moodle VERSION` (for
example, `./init-moodle 27`).

## Docker commands

Remove the container before re-running ./init-moodle:

  $ docker rm -f moodle31


## Login

Username: admin
Password: password
