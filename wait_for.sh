#!/usr/bin/env bash

SECONDS=0

current_time () {
	date -v -0d "+%H:%M:%S"
}

wait_for () {
	local duration=''
	local subject=''
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

	if [ -z $2 ]; then
		subject=''
	fi

	subject=$2

	started_at=$(current_time)
	sleep $duration

	if [ $? == 0 ]; then
		ends_at=$(current_time)
		elapsed=$SECONDS
		echo "${subject},${elapsed},${started_at},${ends_at}"
	elif [ $? == 0 ]; then
		ends_at=$(current_time)
		elapsed=$SECONDS
		echo "${subject},${elapsed},${started_at},${ends_at}"
	fi
}

wait_for $1 $2
