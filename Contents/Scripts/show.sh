#!/bin/bash
#
# LaunchBar Action Script
#

PATH=/usr/local/bin:$PATH

INFO=$(lpass show "$1")
URL=$(echo "$INFO" | grep '^URL: ' | sed -e 's/URL: //')
PW=$(echo "$INFO" | grep '^Password: ' | sed -e 's/Password: //')
UN=$(echo "$INFO" | grep '^Username: ' | sed -e 's/Username: //')

[ -z $PW ] || (echo "$PW" | pbcopy; sleep 1)
[ -z $UN ] || (echo "$UN" | pbcopy; sleep 1)

echo "$URL"
echo "$INFO"
