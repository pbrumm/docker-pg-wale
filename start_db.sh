sysctl -w kernel.shmmax=4418740224
/bin/su postgres -c '/usr/pgsql-9.2/bin/postgres -D /var/lib/pgsql/9.2/data  -c config_file=/var/lib/pgsql/9.2/data/postgresql.conf'
