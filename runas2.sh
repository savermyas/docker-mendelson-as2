#!/usr/bin/env bash
# TODO: SIGTERM trap - https://www.ctl.io/developers/blog/post/gracefully-stopping-docker-containers/
export DISPLAY=:1
cd ./mendelson
vncserver

sh ./mendelson_as2_start.sh

vncserver -kill :1
