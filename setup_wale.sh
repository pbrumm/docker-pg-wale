# Assumption: the group is trusted to read secret information
umask u=rwx,g=rx,o=
mkdir -p /etc/wal-e.d/env
echo "$AWS_SECRET_ACCESS_KEY" > /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY
echo "$AWS_ACCESS_KEY" > /etc/wal-e.d/env/AWS_ACCESS_KEY_ID
#s3://some-bucket/directory/or/whatever
echo "$WALE_S3_PREFIX" > /etc/wal-e.d/env/WALE_S3_PREFIX
chown -R root:postgres /etc/wal-e.d