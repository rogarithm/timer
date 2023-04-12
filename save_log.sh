#!/usr/bin/env bash
input=$(cat -)
subject=$(echo $input | cut -d, -f1)
elapsed=$(echo $input | cut -d, -f2)
started_at=$(echo $input | cut -d, -f3) 
ends_at=$(echo $input | cut -d, -f4)

save_log () {
	if [ "$exitstat" = "SUCCESS" ]; then
		echo "SUCCESS $(($elapsed / 60))m$(($elapsed % 60))s ($started_at-$ends_at)" >> /tmp/.timer_log
		echo $input
	elif [ "$exitstat" = "FAILED" ]; then
		echo "INTERRUPTED $(($elapsed / 60))m$(($elapsed % 60))s ($started_at-$ends_at)" >> /tmp/.timer_log
		echo $input
	fi
}

save_log
