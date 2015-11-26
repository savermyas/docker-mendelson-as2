#!/usr/bin/env bash
# TODO: SIGTERM trap - https://www.ctl.io/developers/blog/post/gracefully-stopping-docker-containers/
# TODO - clean locks in wd on exit

MENDELSON_HOME="/opt/mendelson"
WD="$MENDELSON_HOME/wd"
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
      java -Xmx192M -Xms92M -classpath $CLASSPATH de.mendelson.comm.as2.AS2Shutdown; 
   fi;
   for f in $(find /tmp/ -name ".X*-lock"); do
      num=$(echo $f | rev | cut -d'X' -f 1 | rev | cut -d- -f1)		#get display number
      vncserver -kill :$num						#kill the server
      rm -f $f								#remove the lock
   done
   rm -f $WD/*.lock
}

trap 'cleanup; exit 0' SIGTERM

cleanup

export DISPLAY=:1
vncserver

#=== VNC prepared
cd $WD
java -Xmx1024M -Xms92M -classpath $CLASSPATH de.mendelson.comm.as2.AS2 $1 $2 $3 $4 $5 $6 $7 $8 $9

# APP started

cleanup


