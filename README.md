# docker-mendelson-as2
Mendelson AS2 in the container

1. Clone the repo, enter the folder
2. Edit passwords files 
3. docker-compose up

Issues:
- script runas2.sh doesn't catch SIGTERM
- web-interface doesn't work by default, you need to edit  wd/jetty9/etc/jetty.xml: <SystemProperty name="jetty.base" default="." />/<Property name="jetty.deploy.monitoredDirName" default="../../jetty9/webapps"/>

