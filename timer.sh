#!/usr/bin/env bash

SECONDS=0

trap _stop INT

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

_stop () {
	_display_time
	elapsed=$SECONDS
	echo "stopped: $(($elapsed / 60))m $(($elapsed % 60))s"
}

_timer () {
	local duration=$((25 * 60))
	if [ ! -z $1 ]; then
		duration=$(($1 * 60))
	fi

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

main () {
	case $1 in
		--display-time | -t) shift
			_display_time
			exit 0
			;;
		--set-time | -s) shift
			_timer $1
			exit 0
			;;
		*)
			_timer
			exit 0
			;;
	esac
}

main $@
