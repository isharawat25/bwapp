# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Kolkata 

RUN apt-get update && DEBIAN_FRONTEND=noninteractive

# Update package lists and install required packages
RUN apt-get install -y \
    php7.2 \
    php7.2-mysql \
    mysql-server \
    nano \
    libapache2-mod-security2 \
    wget

# Clone bWAPP repository
COPY bWAPP/ /var/www/html/
RUN rm /var/www/html/index.html
EXPOSE 80
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

RUN cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf


# Start MySQL and Apache in the foreground
CMD service mysql start && apache2ctl start && /bin/bash

# DEV
# CMD /bin/bash