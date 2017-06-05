FROM debian:jessie
EXPOSE 22

# Prepare packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -yq sudo openssh-server python
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/run/sshd && chmod 0755 /var/run/sshd
RUN echo 'UseDNS no' >> /etc/ssh/sshd_config

# Add the Vagrant user
RUN groupadd vagrant
RUN useradd -c "Vagrant" -g vagrant -d /home/vagrant -m -s /bin/bash vagrant
RUN echo 'vagrant:vagrant' | chpasswd
RUN echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
ADD https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 0600 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh
RUN chmod 0700 /home/vagrant/.ssh

CMD ["/usr/sbin/sshd", "-D"]
