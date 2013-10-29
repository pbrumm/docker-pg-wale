FROM centos

RUN yum update -y
RUN curl -O http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm
RUN rpm -ivh pgdg-centos92-9.2-6.noarch.rpm
RUN yum install -y  postgresql92-server postgresql92-contrib
RUN echo 'NETWORKING=yes' > /etc/sysconfig/network
RUN echo -e 'LANG="en_US.UTF-8"\nLC_ALL="en_US.UTF-8"' > /etc/sysconfig/i18n
RUN yum install -y sudo 
RUN curl -O http://djbware.csi.hu/RPMS/daemontools-0.76-112memphis.i386.rpm
RUN rpm -ivh daemontools-0.76-112memphis.i386.rpm
RUN rm -rf /var/lib/pgsql/9.2/data/*
sysctl -w kernel.shmmax=4418740224
echo "shared_buffers = 4GB" >> /var/lib/pgsql/9.2/data/postgresql.conf

EXPOSE 5432