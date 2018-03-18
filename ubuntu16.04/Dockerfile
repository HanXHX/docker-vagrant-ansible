FROM ubuntu:16.04
EXPOSE 22

COPY run.sh /root/run.sh
COPY install_packages /usr/sbin/install_packages
RUN chmod 755 /usr/sbin/install_packages
RUN /bin/sh /root/run.sh

CMD ["/usr/sbin/sshd", "-D"]
