FROM centos:latest

MAINTAINER Dmitry Myasnikov <saver_is_not@bk.ru>

RUN yum update; yum install -y java-1.8.0-openjdk unzip tigervnc-server xorg-x11-server-Xvfb; yum clean all
RUN curl -L "http://downloads.sourceforge.net/project/mec-as2/install_mendelson_opensource_as2_1.1b47.zip" > mendelson.zip; unzip mendelson.zip -d mendelson; rm -f mendelson.zip
ADD webpasswd /mendelson/passwd
ADD vncpasswd /mendelson/vncpasswd
ADD runas2.sh /mendelson/scripts/runas2.sh
RUN echo "$(cat /mendelson/vncpasswd)" > /tmp/passwd; echo "$(cat /mendelson/vncpasswd)" >> /tmp/passwd; vncpasswd < /tmp/passwd

RUN mv mendelson /opt/

RUN mkdir /opt/mendelson/wd/jetty9; mv /opt/mendelson/jetty9/etc /opt/mendelson/wd/jetty9/; mv /opt/mendelson/certificates.p12 /opt/mendelson/wd/; mv /opt/mendelson/log4j.properties /opt/mendelson/wd/
#TODO - edit jetty path in xml

EXPOSE 8080 5901

CMD /opt/mendelson/scripts/runas2.sh
