#!/usr/bin/env bash

SECONDS=0

current_time () {
	date -v -0d "+%H:%M:%S"
}

timer () {
	local duration=''
	local started_at=''
	local ends_at=''

	if [ -z $1 ]; then
		echo 'please specify duration'
	fi

	if [ $(echo $1 | cut -c1,2) = '-s' ]; then
		duration=$(echo $1 | cut -c3-)
	fi
	if [ $(echo $1 | cut -c1,2) = '-m' ]; then
		duration=$(( $(echo $1 | cut -c3-) * 60 ))
	fi

	started_at=$(current_time)
	sleep $duration

	if [ $? == 0 ]; then
		ends_at=$(current_time)
		elapsed=$SECONDS
		echo "SUCCESS,${elapsed},${started_at},${ends_at}"
	elif [ $? == 0 ]; then
		ends_at=$(current_time)
		elapsed=$SECONDS
		echo "FAILED,${elapsed},${started_at},${ends_at}"
	fi
}

timer $1
