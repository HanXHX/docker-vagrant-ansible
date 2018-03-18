FROM ubuntu:16.04
EXPOSE 22

COPY run.sh /root/run.sh
RUN /bin/sh /root/run.sh

CMD ["/usr/sbin/sshd", "-D"]
