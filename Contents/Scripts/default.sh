#!/bin/bash
#
# LaunchBar Action Script
#

PATH=/usr/local/bin:$PATH
LPU=linktohack@gmail.com

if [ "$LB_SCRIPT_TYPE" == "suggestions" ]; then
	if VAULT=$(lpass ls --color=never); then
		# if [ "$@" == "" ]; then
		# 	URL="$(osascript -e "tell application \"Google Chrome\"
		# 							 get URL of active tab of first window
		# 						 end tell")"
		# 	DOMAIN=$(echo "$URL" | sed -E -e 's/.*:\/\/([^\/]+).*/\1/')
		# 	echo "$VAULT" | grep -i "$DOMAIN" 
		# 	echo "$URL"
		# else
			echo "$VAULT" | grep -i "$@" 
		# fi
		echo Logout
	else
		echo Login
	fi
else
	for ARG in "$@"; do
		if [ "$ARG" == "Login" ]; then
			while ! VAULT=`lpass ls --color=never`; do
				lpass login "$LPU"
			done
		elif [ "$ARG" == "Logout" ]; then
			yes Y | lpass logout
		else
			ID=$(echo "$ARG" | sed -e 's/^.* \[id: //' -e 's/\]$//')
			INFO=$(lpass show "$ID")
			URL=$(echo "$INFO" | grep '^URL: ' | sed -e 's/URL: //')
			PW=$(echo "$INFO" | grep '^Password: ' | sed -e 's/Password: //')
			UN=$(echo "$INFO" | grep '^Username: ' | sed -e 's/Username: //')

			[ -z $PW ] || (echo "$PW" | pbcopy; sleep 0.2)
			[ -z $UN ] || (echo "$UN" | pbcopy)

			echo "$URL"
			echo "$INFO"
		fi
	done
fi
