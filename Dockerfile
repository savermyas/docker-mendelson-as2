FROM centos:latest

MAINTAINER Dmitry Myasnikov <saver_is_not@bk.ru>

ENV MENDELSON_HOME /opt/mendelson/as2
RUN yum update -y && \
    yum install -y java-1.8.0-openjdk unzip tigervnc-server xorg-x11-server-Xvfb && \
    yum clean all
RUN mkdir -p $MENDELSON_HOME && \
    curl -L "http://downloads.sourceforge.net/project/mec-as2/install_mendelson_opensource_as2_1.1b47.zip" > mendelson.zip && \ 
    unzip mendelson.zip -d $MENDELSON_HOME; rm -f mendelson.zip
ADD custom $MENDELSON_HOME/custom
VOLUME $MENDELSON_HOME/wd

EXPOSE 8080 5901
ENTRYPOINT $MENDELSON_HOME/custom/runas2.sh
