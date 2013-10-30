#!/bin/bash
sysctl -w kernel.shmmax=4418740224
/sbin/service crond start

su - postgres -c "crontab -l | { cat; echo \"0 3 * * * /usr/local/bin/envdir /var/lib/pgsql/9.2/data/env /usr/bin/wal-e backup-push /var/lib/pgsql/9.2/data\";} | crontab -"

if [[ -n $1 ]]; then
  echo -e "$1\n$1" | (passwd --stdin root)
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
  /sbin/service sshd start
fi

/bin/su postgres -c '/usr/pgsql-9.2/bin/postgres -D /var/lib/pgsql/9.2/data  -c config_file=/var/lib/pgsql/9.2/data/postgresql.conf'
