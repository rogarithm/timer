#!/usr/bin/env bash

trap _pause INT

_timer () {
	local duration=$((3))

	sleep $duration
	if [ $? == 0 ]; then
		echo "sleep complete"
	fi
}

_pause () {
	echo "pause sleep"
}

_timer
