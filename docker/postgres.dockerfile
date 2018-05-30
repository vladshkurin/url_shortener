FROM postgres:9.4.7
MAINTAINER developer@cognibox.com

# Change the locale to en_CA
RUN localedef -i en_CA -c -f UTF-8 -A /usr/share/locale/locale.alias en_CA.UTF-8
ENV LANG en_CA.utf8

# Change configuration options
COPY docker/postgres_setup.sh /docker-entrypoint-initdb.d/postgres_setup.sh
