#!/bin/bash

prntvalue () {
	echo $XML | xmlstarlet sel -t -v "$1"
}
prntnumber () {
	printf "%.1f\n" $(prntvalue "$1" | sed 's/\./,/')
}

XML=$(wget -q -O - "http://localhost:8080/sabnzbd/api?mode=qstatus&output=xml&apikey=756f477966284731b45309ff9447772f")

let nojobs=$(echo $XML | xmlstarlet sel -t -v "count(/queue/jobs/job)")

if [[ $nojobs > 0 ]];then
	timeleft=$(prntvalue "/queue/timeleft")
	filename=$(prntvalue "/queue/jobs/job/filename")
	mbleft=$(prntvalue "/queue/jobs/job/mbleft")
	totmbleft=$(prntnumber "/queue/mbleft")
	totmb=$(prntnumber "/queue/mb")
	kbpersec=$(prntnumber "/queue/kbpersec")

	echo "$timeleft @ $kbpersec k/s  $totmbleft/$totmb MiB"
	echo
	for i in $(seq 1 $nojobs);
	do
		FILE=$(prntvalue "/queue/jobs/job[$i]/filename" | awk '{print $1}')
		SIZE=$(prntnumber $(prntvalue "/queue/jobs/job[$i]/mbleft" | awk '{print $1}'))
		echo "${FILE:0:25}... : $SIZE MiB"
	done
else
	echo -e "No jobs..."
fi

exit 0
