FROM ubuntu:14.04

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B0DE9C5DEBF486359EB255B03B0153D0383F073D
RUN echo "deb http://ppa.launchpad.net/tsuru/ppa/ubuntu trusty main"  > /etc/apt/sources.list.d/tsuru.list
RUN apt-get update && apt-get install -y gandalf-server openssh-server patch software-properties-common
RUN apt-add-repository ppa:tsuru/ppa -y
RUN service gandalf-server stop 1>&2 2>/dev/null || true

COPY gandalf.conf /etc/

RUN mkdir -p /home/git/bare-template/hooks
COPY pre-receive /home/git/bare-template/hooks/
RUN chmod +x /home/git/bare-template/hooks/pre-receive
RUN chown -R git:git /home/git/bare-template

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8000

ENTRYPOINT ["/run.sh"]


