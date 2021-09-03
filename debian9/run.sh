#!/bin/sh

set -e

install_packages sudo openssh-server python3 wget ca-certificates
mkdir -p /var/run/sshd && chmod 0755 /var/run/sshd
echo 'UseDNS no' >> /etc/ssh/sshd_config

groupadd vagrant
useradd -c "Vagrant" -g vagrant -d /home/vagrant -m -s /bin/bash vagrant
echo 'vagrant:vagrant' | chpasswd
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
mkdir -p /home/vagrant/.ssh
wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
