#!/bin/bash -eux

useradd -d /home/ceph -m ceph

echo "ceph ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph
chmod 0440 /etc/sudoers.d/ceph

mkdir /home/ceph/.ssh
cp /vagrant/ssh/* /home/ceph/.ssh/
cp /home/ceph/.ssh/id_rsa.pub /home/ceph/.ssh/authorized_keys
chown -R ceph:ceph /home/ceph/.ssh
chmod 600 /home/ceph/.ssh/id_rsa

for i in {1..3}; do
    echo 192.168.1.5${i} ceph-mon${i} >> /etc/hosts
    echo 192.168.1.10${i} ceph-osd${i} >> /etc/hosts
    echo 192.168.1.15${i} ceph-mds${i} >> /etc/hosts
done

wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | apt-key add -

apt-add-repository 'deb http://ceph.com/debian-firefly/ trusty main'
#apt-add-repository 'deb http://ceph.com/packages/ceph-extras/debian trusty main'
#apt-add-repository 'deb http://gitbuilder.ceph.com/apache2-deb-trusty-x86_64-basic/ref/master trusty main'
#apt-add-repository 'deb http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master trusty main'

apt-get update
apt-get install -y ceph-deploy

cd /home/ceph
sudo -u ceph ssh-keyscan -H localhost >> /home/ceph/.ssh/known_hosts
chown ceph:ceph /home/ceph/.ssh/known_hosts
sudo -u ceph HOME=/home/ceph ceph-deploy install localhost
