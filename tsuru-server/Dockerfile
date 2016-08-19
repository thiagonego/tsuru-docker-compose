FROM alpine:3.2

# INSTALANDO DEPENDÊNCIAS
RUN apt-get update -y
RUN apt-add-repository ppa:tsuru/ppa -y
RUN apt-add-repository ppa:tsuru/snapshots -y 
RUN apt-get install linux-image-extra-$(uname -r) -qqy
RUN apt-get install jq screen curl mercurial git bzr software-properties-common apt-transport-https -y
RUN apt-get update -y

# INSTALANDO O TSURU SERVER
RUN apt-get install tsuru-server tsuru-admin tsuru-client -y
RUN service tsuru-server-api stop
RUN mkdir -p /etc/tsuru
COPY tsuru.conf /etc/tsuru/tsuru.conf
RUN service tsuru-server-api start

# INSTALLING ARCHIVE-SERVER
RUN apt-get install archive-server -y
RUN service archive-server stop || true
RUN echo "export ARCHIVE_SERVER_READ=http://127.0.0.1:6060" | tee -a ~git/.bash_profile > /dev/null
RUN echo "export ARCHIVE_SERVER_WRITE=http://127.0.0.1:6161" | tee -a ~git/.bash_profile > /dev/null
RUN echo 'export ARCHIVE_SERVER_OPTS="-dir=/var/lib/archive-server/archives -read-http=0.0.0.0:6060 -write-http=127.0.0.1:6161"' | tee -a /etc/default/archive-server > /dev/null 2>&1
RUN service archive-server start


# # INSTALLING GANDALF
# RUN apt-get update -y
# RUN apt-add-repository ppa:tsuru/ppa -y
# RUN apt-get install curl python-software-properties -y
# RUN apt-get update -y
# RUN apt-get install gandalf-server -y
# 
# RUN apt-get install archive-server -y
# 
# # CONFIG GANDALF
# RUN mkdir -p /home/git/bare-template/hooks
# COPY pre-receive /home/git/bare-template/hooks/pre-receive
# RUN chmod +x /home/git/bare-template/hooks/pre-receive
# RUN chown -R git:git /home/git/bare-template
# 
# RUN cat | tee -a /home/git/.bash_profile <<EOF \
# export $ARCHIVE_SERVER_READ=http://localhost:3232 $ARCHIVE_SERVER_WRITE=http://127.0.0.1:3131 \
# EOF