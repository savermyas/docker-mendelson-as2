#!/usr/bin/env bash

WD="$MENDELSON_HOME/wd"

#==== Initialize if WD is empty ====
if find "$WD" -mindepth 1 -print -quit | grep -q .; then
    echo "Using data from previous run"
else
    echo "Workdir $WD is empty, performing preparation"
    ln -s $MENDELSON_HOME/custom/webpasswd $WD/passwd
    ln -s $MENDELSON_HOME/jetty9 $WD/jetty9
    cp $MENDELSON_HOME/certificates.p12 $WD/
    cp $MENDELSON_HOME/log4j.properties $WD/
    mkdir -p $WD/log
fi

CLASSPATH=$MENDELSON_HOME/as2.jar:$MENDELSON_HOME/jetty9/start.jar
JARDIRS=(
"jlib" 
"jlib/mina"
"jlib/help"
"jlib/vaadin"
"jlib/httpclient"
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

echo "$(cat $MENDELSON_HOME/custom/vncpasswd)" > /tmp/passwd
echo "$(cat $MENDELSON_HOME/custom/vncpasswd)" >> /tmp/passwd
vncpasswd < /tmp/passwd 
rm -f /tmp/passwd

export DISPLAY=:1
vncserver

#=== VNC prepared
cd $WD
exec java -Xmx1024M -Xms92M -classpath $CLASSPATH de.mendelson.comm.as2.AS2 $1 $2 $3 $4 $5 $6 $7 $8 $9
# APP started

cleanup
