sysctl -w kernel.shmmax=4418740224
service postgresql-9.2 start
sudo -u postgres createuser -P -d -r -s docker
sudo -u postgres createdb -O docker docker