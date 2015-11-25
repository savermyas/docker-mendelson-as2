FROM centos:latest

MAINTAINER Dmitry Myasnikov <saver_is_not@bk.ru>

RUN yum update; yum install -y java-1.8.0-openjdk unzip tigervnc-server xorg-x11-server-Xvfb; yum clean all
RUN curl -L "http://downloads.sourceforge.net/project/mec-as2/install_mendelson_opensource_as2_1.1b47.zip" > mendelson.zip; unzip mendelson.zip -d mendelson; rm -f mendelson.zip
ADD webpasswd /mendelson/passwd
ADD vncpasswd /mendelson/vncpasswd
RUN ls -lah /mendelson
ADD runas2.sh /mendelson/runas2.sh
RUN echo "$(cat /mendelson/vncpasswd)" > /tmp/passwd; echo "$(cat /mendelson/vncpasswd)" >> /tmp/passwd; vncpasswd < /tmp/passwd
#RUN vncserver

EXPOSE 8080 5901

CMD /mendelson/runas2.sh

#RUN export DISPLAY=:1 && \
#Xvfb :1 -screen 0 1024x768x16 && \
#cd ./mendelson && xvfb-run ./mendelson_as2_start.sh