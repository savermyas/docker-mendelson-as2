#!/usr/bin/env bash

WD="$MENDELSON_HOME/wd"

#==== Initialize if WD is empty ====
if find "$WD" -mindepth 1 -print -quit | grep -q .; then
    echo "Using data from previous run"
else
    echo "Workdir $WD is empty, performing preparation"
fi

# webas2 will crash if the file "database.acl" is not present in $WD
if [ ! -f $WD/database.acl ]; then
    echo "File database.acl not found. Using default."
    cp $MENDELSON_HOME/database.acl $WD/database.acl
fi

if [ ! -f $WD/webpasswd ]; then
    echo "Web password file not found. Creating default."
    cp $MENDELSON_HOME/custom/webpasswd $WD/webpasswd
    ln -s $WD/webpasswd $WD/passwd
fi

if [ ! -f $WD/vncpasswd ]; then
    echo "VNC password file not found. Creating default."
    cp $MENDELSON_HOME/custom/vncpasswd $WD/vncpasswd
fi

if [ ! -f $WD/certificates.p12 ]; then
    echo "Certificates storage not found. Creating default."
    cp $MENDELSON_HOME/certificates.p12 $WD/
fi

if [ ! -f $WD/log4j.properties ]; then
    echo "Logging properties file not found. Creating default."
    cp $MENDELSON_HOME/log4j.properties $WD/
fi

if [ ! -d $WD/jetty9 ]; then
    echo "Preparing Jetty working directory."
    mkdir -p $WD/jetty9
    etc  lib  license-eplv10-aslv20.html  logs  notice.html  README.TXT  resources  start.ini  start.jar  VERSION.txt  webapps
    ln -s $MENDELSON_HOME/jetty9/lib $WD/jetty9/lib
    ln -s $MENDELSON_HOME/jetty9/start.ini $WD/jetty9/start.ini
    ln -s $MENDELSON_HOME/jetty9/start.jar $WD/jetty9/start.jar
    ln -s $MENDELSON_HOME/jetty9/webapps $WD/jetty9/webapps
    cp -r $MENDELSON_HOME/jetty9/etc $WD/jetty9/
    cp -r $MENDELSON_HOME/jetty9/logs $WD/jetty9/
    cp -r $MENDELSON_HOME/jetty9/resources $WD/jetty9/
fi

mkdir -p $WD/log

CLASSPATH=$MENDELSON_HOME/as2.jar:$MENDELSON_HOME/jetty9/start.jar
JARDIRS=(
"jlib"
"jlib/dark"
"jlib/db"
"jlib/help"
"jlib/httpclient"
"jlib/jpod"
"jlib/mina"
"jlib/svg"
"jlib/vaadin"
"jetty9/lib"
)

for JARDIR in ${JARDIRS[@]}
do
   if [ -d "$MENDELSON_HOME/$JARDIR" ]; then
      for jar in `ls $MENDELSON_HOME/$JARDIR/*.jar ../$JARDIR/*.zip 2>/dev/null`
      do
          CLASSPATH=$CLASSPATH:$jar
      done
   fi
done

cleanup() {
   if [ "$(pidof java)" ]; then
      echo "Gracefully stopping Mendelson AS2"
      java -Xmx192M -Xms92M -classpath $CLASSPATH de.mendelson.comm.as2.AS2Shutdown;
   fi;
   for f in $(find /tmp/ -name ".X*-lock"); do
      num=$(echo $f | rev | cut -d'X' -f 1 | rev | cut -d- -f1)		#get display number
      vncserver -kill :$num						#kill the server
      rm -f $f								#remove the lock
   done
   rm -f $WD/*.lock
}

trap 'cleanup; exit 0' SIGINT SIGTERM

cleanup

echo "$(cat $WD/vncpasswd)" > /tmp/passwd
echo "$(cat $WD/vncpasswd)" >> /tmp/passwd
vncpasswd < /tmp/passwd
rm -f /tmp/passwd

export DISPLAY=:1
vncserver

#=== VNC prepared
cd $WD
exec java -Xmx1024M -Xms92M -classpath $CLASSPATH de.mendelson.comm.as2.AS2 $1 $2 $3 $4 $5 $6 $7 $8 $9
# APP started

cleanup
