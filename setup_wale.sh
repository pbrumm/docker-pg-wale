#!/bin/bash
# Assumption: the group is trusted to read secret information
umask u=rwx,g=rx,o=
mkdir -p /var/lib/pgsql/9.2/data/env
echo "$AWS_SECRET_ACCESS_KEY" > /var/lib/pgsql/9.2/data/env/AWS_SECRET_ACCESS_KEY
echo "$AWS_ACCESS_KEY" > /var/lib/pgsql/9.2/data/env/AWS_ACCESS_KEY_ID
#s3://some-bucket/directory/or/whatever
echo "$WALE_S3_PREFIX" > /var/lib/pgsql/9.2/data/env/WALE_S3_PREFIX
chown -R root:postgres /var/lib/pgsql/9.2/data/env


# wal-e specific
echo "wal_level = archive" >> /var/lib/pgsql/9.2/data/postgresql.conf
echo "archive_mode = on" >> /var/lib/pgsql/9.2/data/postgresql.conf
echo "archive_command = '/usr/local/bin/envdir /var/lib/pgsql/9.2/data/env /usr/bin/wal-e wal-push %p'" >> /var/lib/pgsql/9.2/data/postgresql.conf
echo "archive_timeout = 60" >> /var/lib/pgsql/9.2/data/postgresql.conf

su - postgres -c "crontab -l | { cat; echo \"0 3 * * * /usr/local/bin/envdir /var/lib/pgsql/9.2/data/env /usr/bin/wal-e backup-push /var/lib/pgsql/9.2/data\";} | crontab -"