#!/usr/bin/env bash

SECONDS=0

trap _stop INT

_notify_with_sound () {
	local location=/System/Library/Sounds
	local sound=Ping
	if [ ! -z $1 ]; then
		sound=$1
	fi

	afplay ${location}/${sound}.aiff
}

_notify_with_display () {
	local start_time=$1
	local end_time=$2
	local elapsed=$3

	local title="세션 완료: 약 $(($elapsed / 60))분"
	local text="$start_time - $end_time"

	echo display notification \"${text}\" with title \"${title}\" | osascript
}

_display_time () {
	echo $(date -v -0d "+%H:%M")
}

_stop () {
	_display_time
	elapsed=$SECONDS
	echo "stopped: $(($elapsed / 60))m $(($elapsed % 60))s"

	local title="세션 중단: 약 $(($elapsed / 60))분"

	echo display notification \"\" with title \"${title}\" | osascript
}

_help () {
	local sound_location=/System/Library/Sounds
	local sounds=$(ls $sound_location | sed -e s/\.aiff//g | gsed -e 's/\n/ /g')

	cat << EOF
Usage: timer [-d|-c|-e|-h] [time]
-d: display time
-c: set 1 study session
-e: play notify sound 2 times
-h: show help doc

Sounds can be:
Basso Blow Bottle Frog Funk
Glass Hero Morse Ping Pop
Purr Sosumi Submarine Tink
EOF
}

_timer () {
	local duration=$((25 * 60))
	if [ ! -z $1 ]; then
		duration=$(($1 * 60))
	fi

	#todo _display_time과 중복 제거
	start_time="$(date -v -0d "+%H:%M")"
	sleep $duration
	if [ $? == 0 ]; then
		end_time="$(date -v -0d "+%H:%M")"
		_notify_with_sound
		_notify_with_display $start_time $end_time $SECONDS
		elapsed=$SECONDS
		echo "완료: $(($elapsed / 60))분 $(($elapsed % 60))초 / $start_time - $end_time" >> /tmp/.timer_log
	fi
}

main () {
	case $1 in
		--display | -d) shift
			_display_time
			exit 0
			;;
		--concentrate | -c) shift
			_timer 25 && _timer 5
			exit 0
			;;
		--end | -e) shift
			_notify_with_sound && _notify_with_sound
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
