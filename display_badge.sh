#!/usr/bin/env bash
input=$(cat -)
subject=$(echo $input | cut -d, -f1)
elapsed=$(echo $input | cut -d, -f2)
started_at=$(echo $input | cut -d, -f3) 
ends_at=$(echo $input | cut -d, -f4)


display_badge() {

	local title="완료: 약 $(($elapsed / 60))m $(($elapsed % 60))s"
	local text="${started_at}-${ends_at}"

	echo display notification \"${text}\" with title \"${title}\" | osascript
	echo $input
	exit 0
}

display_badge
