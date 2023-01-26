#!/usr/bin/env bash

trap _pause INT

_notify_with_sound () {
	local sound=/System/Library/Sounds/Ping.aiff

	afplay $sound
}

_notify_with_display () {
	local text='session end'
	local title='Timer'

	echo display notification \"${text}\" with title \"${title}\" | osascript
}

_display_time () {
	echo $(date -v -0d "+%H:%M:%S") | sed -e 's/  / /g'
}

_timer () {
	local duration=$((3))

	_display_time
	sleep $duration
	if [ $? == 0 ]; then
		_notify_with_sound
		_notify_with_display
		_display_time
		elapsed=$SECONDS
		echo "complete: $(($elapsed / 60))m $(($elapsed % 60))s"
	fi
}

_pause () {
	_display_time
	elapsed=$SECONDS
	echo "paused: $(($elapsed / 60))m $(($elapsed % 60))s"
}

SECONDS=0
_timer
