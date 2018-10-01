FROM centos:7.3.1611

MAINTAINER Dmitry Myasnikov <saver_is_not@bk.ru>

ENV MENDELSON_HOME /opt/mendelson/as2
ARG MENDELSON_VERSION=1.1b51

RUN yum install -y java-1.8.0-openjdk unzip tigervnc-server xorg-x11-server-Xvfb && \
    yum clean all && mkdir -p $MENDELSON_HOME

COPY custom $MENDELSON_HOME/custom

COPY mendelson-$MENDELSON_VERSION.zip /tmp/mendelson.zip

RUN unzip /tmp/mendelson.zip -d $MENDELSON_HOME; rm -f /tmp/mendelson.zip

VOLUME $MENDELSON_HOME/wd

EXPOSE 8080 5901
ENTRYPOINT $MENDELSON_HOME/custom/runas2.sh
