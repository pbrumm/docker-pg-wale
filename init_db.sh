#!/bin/bash
sysctl -w kernel.shmmax=4418740224
service postgresql-9.2 initdb
echo -e "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/9.2/data/pg_hba.conf
echo "random_page_cost = 2.0" >> /var/lib/pgsql/9.2/data/postgresql.conf
echo "listen_addresses='*'" >> /var/lib/pgsql/9.2/data/postgresql.conf
chown -R postgres:postgres /var/lib/pgsql/9.2/data
echo "shared_buffers = 4GB" >> /var/lib/pgsql/9.2/data/postgresql.conf

