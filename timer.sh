case $1 in
	-s) shift
		echo $1 >> /tmp/.timer_log
		shift
		;;
esac

case $1 in
	--test) shift
		for t in $@
		do
			if [ $t -ge 5 ]; then
				./wait_for.sh -s${t} | ./display_badge.sh | ./save_log.sh | ./notify_with_sound.sh
			elif [ $t -lt 5 ]; then
				./wait_for.sh -s${t} | ./display_badge.sh | ./notify_with_sound.sh
			fi;
		done
		;;
esac

case $1 in
	--) shift
		for t in $@
		do
			if [ $t -ge 10 ]; then
				./wait_for.sh -m${t} | ./display_badge.sh | ./save_log.sh | ./notify_with_sound.sh
			elif [ $t -le 10 ]; then
				./wait_for.sh -m${t} | ./display_badge.sh | ./notify_with_sound.sh
			fi;
		done
esac

exit 0
