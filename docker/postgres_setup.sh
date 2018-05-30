#!/bin/bash

sed -i \
    -e "s:#bgwriter_lru_maxpages = 100:bgwriter_lru_maxpages = 0:" \
    -e "s:#fsync = on:fsync = off:" \
    -e "s:#synchronous_commit = on:synchronous_commit = off:" \
    -e "s:#full_page_writes = on:full_page_writes = off:" \
    -e "s:datestyle = 'iso, mdy':datestyle = 'iso, ymd':" \
    -e "s:en_US:ru_RU:" \
    -e "s:#max_locks_per_transaction = 64:max_locks_per_transaction = 128:" \
    $PGDATA/postgresql.conf
