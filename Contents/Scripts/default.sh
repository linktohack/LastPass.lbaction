#!/bin/bash
#
# LaunchBar Action Script
#

PATH=/usr/local/bin:$PATH
LPU=linktohack@gmail.com

while ! VAULT=`lpass ls --color=never`; do
    lpass login "$LPU"
done

RESULT=$(echo "$VAULT" | sed -e 's/\\/\\\\/g' \
                             -e 's/^/{ "title": "/' \
                             -e 's/ \[id: /", "actionArgument": "/' \
                             -e 's/]$/", "action": "show.sh" },/')
echo "[ $RESULT ]"
