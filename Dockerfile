FROM centos

RUN yum update -y
RUN curl -O http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm
RUN rpm -ivh pgdg-centos92-9.2-6.noarch.rpm
RUN yum install -y  postgresql92-server postgresql92-contrib
RUN echo 'NETWORKING=yes' > /etc/sysconfig/network
RUN echo -e 'LANG="en_US.UTF-8"\nLC_ALL="en_US.UTF-8"' > /etc/sysconfig/i18n
RUN yum install -y sudo glibc.i686 git

RUN echo -e "[ivarch]\nname=RPMs from ivarch.com\nbaseurl=http://www.ivarch.com/programs/rpms/\$basearch/\nenabled=1\ngpgcheck=1" > /etc/yum.repos.d/ivarch.repo
RUN rpm --import http://www.ivarch.com/personal/public-key.txt
RUN yum install -y pv lzop
RUN yum install -y libevent-devel python-setuptools gcc make python-devel
RUN curl -O http://djbware.csi.hu/RPMS/daemontools-0.76-112memphis.i386.rpm
RUN rpm -ivh daemontools-0.76-112memphis.i386.rpm
RUN git clone https://github.com/wal-e/wal-e.git
RUN cd wal-e; python2.6 setup.py install
RUN rm -rf /var/lib/pgsql/9.2/data/*
sysctl -w kernel.shmmax=4418740224
echo "shared_buffers = 4GB" >> /var/lib/pgsql/9.2/data/postgresql.conf

RUN yum install -y vixie-cron crontabs
RUN /sbin/chkconfig crond on
ADD . /usr/bin/
EXPOSE 5432