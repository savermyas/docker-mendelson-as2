#!/usr/bin/env bash
# TODO: SIGTERM trap - https://www.ctl.io/developers/blog/post/gracefully-stopping-docker-containers/
# TODO - clean locks in wd on exit
   for f in $(find /tmp/ -name ".X*-lock"); do
      num=$(echo $f | rev | cut -d'X' -f 1 | rev | cut -d- -f1)	#get display number
      vncserver -kill :$num					#kill the server
      rm -f $f							#remove the lock
   done

export DISPLAY=:1
cd ./opt/mendelson/wd
vncserver


#=== VNC prepared


CLASSPATH=../as2.jar:../jetty9/start.jar
export CLASSPATH

if [ -d ../jlib ]; then
    JARDIR=../jlib
    export JARDIR
    for jar in `ls $JARDIR/*.jar $JARDIR/*.zip 2>/dev/null`
    do
        CLASSPATH=$CLASSPATH:$jar
    done
fi
if [ -d ../jlib/mina ]; then
    MINADIR=../jlib/mina
    export MINADIR
    for jar in `ls $MINADIR/*.jar $MINADIR/*.zip 2>/dev/null`
    do
        CLASSPATH=$CLASSPATH:$jar
    done
fi
if [ -d ../jlib/help ]; then
    HELPDIR=../jlib/help
    export HELPDIR
    for jar in `ls $HELPDIR/*.jar $HELPDIR/*.zip 2>/dev/null`
    do
        CLASSPATH=$CLASSPATH:$jar
    done
fi
if [ -d ../jlib/vaadin ]; then
    VAADINDIR=../jlib/vaadin
    export VAADINDIR
    for jar in `ls $VAADINDIR/*.jar $VAADINDIR/*.zip 2>/dev/null`
    do
        CLASSPATH=$CLASSPATH:$jar
    done
fi
if [ -d ../jetty9/lib ]; then
    JETTYLIBDIR=../jetty9/lib
    export JETTYLIBDIR
    for jar in `ls $JETTYLIBDIR/*.jar $JETTYLIBDIR/*.zip 2>/dev/null`
    do
        CLASSPATH=$CLASSPATH:$jar
    done
fi
if [ -d ../jlib/httpclient ]; then
    HTTPLIBDIR=../jlib/httpclient
    export HTTPLIBDIR
    for jar in `ls $HTTPLIBDIR/*.jar $HTTPLIBDIR/*.zip 2>/dev/null`
    do
    CLASSPATH=$CLASSPATH:$jar
    done
fi
java -Xmx1024M -Xms92M -classpath $CLASSPATH de.mendelson.comm.as2.AS2 $1 $2 $3 $4 $5 $6 $7 $8 $9


# APP started




#sh ./mendelson_as2_start.sh

vncserver -kill :1

