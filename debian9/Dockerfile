FROM bitnami/minideb:stretch
EXPOSE 22

COPY run.sh /root/run.sh
RUN /bin/sh /root/run.sh

CMD ["/usr/sbin/sshd", "-D"]
