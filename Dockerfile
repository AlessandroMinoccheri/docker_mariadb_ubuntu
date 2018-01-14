FROM ubuntu:16.04

MAINTAINER alessandro.minoccheri@studiomado.it

ENV MARIADB_VERSION=10.1
ENV DB_NAME=mydb
ENV DB_USER=myuser
ENV DB_PASSWORD=mypassword

ADD create_mysql_user_and_database.sh /user/local/bin/create_mysql_user_and_database.sh
ADD db.sql /user/local/db.sql

# Install MariaDB from repository.
RUN echo "deb http://ftp.osuosl.org/pub/mariadb/repo/10.1/ubuntu xenial main" > /etc/apt/sources.list.d/mariadb.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes mariadb-server mariadb-server-10.1

RUN apt-get install -y vim
RUN sed -ie "s/^bind-address\s*=\s*127\.0\.0\.1$/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

EXPOSE 3306

ENTRYPOINT /etc/init.d/mysql start && chmod 755 /user/local/bin/create_mysql_user_and_database.sh && ./user/local/bin/create_mysql_user_and_database.sh && bash
