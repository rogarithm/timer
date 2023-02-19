#!/usr/bin/env bash

SECONDS=0

trap _stop INT

_notify_with_sound () {
	local sound=/System/Library/Sounds/Ping.aiff

	afplay $sound
}

_notify_with_display () {
	local text='- 몸이 굳어있다면 스트레칭 하기\n
- 손에 힘 들어가있다면 힘 빼기'
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

_help () {
	local usage='Usage: timer [-t|-s] [time]
	-t: display time
	-s: set time'

	echo "$usage"
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
		--display | -d) shift
			_display_time
			exit 0
			;;
		--concentrate | -c) shift
			_timer 60
			exit 0
			;;
		--help | -h) shift
			_help
			exit 0
			;;
		*)
			_timer $1
			exit 0
			;;
	esac
}

main $@
