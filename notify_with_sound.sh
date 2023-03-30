#!/usr/bin/env bash
input=$(cat -)
exitstatus=$(echo $input | cut -d, -f1)

notify_with_sound () {
	local location=/System/Library/Sounds

	if [ "$exitstatus" = "SUCCESS" ]; then
		afplay ${location}/Ping.aiff
	else
		afplay ${location}/Blow.aiff
	fi
}

notify_with_sound
